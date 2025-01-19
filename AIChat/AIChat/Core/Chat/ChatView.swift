//
//  ChatView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import SwiftUI

struct ChatView: View {

  @Environment(AIManager.self) var aiManager
  @Environment(AvatarManager.self) var avatarManager

  @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
  @State private var avatar: AvatarModel?
  @State private var currentUser: UserModel? = .mock
  @State private var textFieldText: String = ""

  @State private var scrollPosition: String?

  @State private var showChatSettings: AnyAppAlert?
  @State private var showAlert: AnyAppAlert?
  @State private var showProfileModal: Bool = false

  var avatarId: String = AvatarModel.mock.avatarId

  var body: some View {
    VStack(spacing: 0) {
      scrollViewSection
      textFieldSection
        .zIndex(9999)
        .animation(.bouncy, value: showProfileModal)
    }
    .navigationTitle(avatar?.name ?? "Chat")
    .toolbarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Image(systemName: "ellipsis")
          .foregroundStyle(.accent)
          .padding(8)
          .anyButton(action: onChatSettingsPressed)
      }
    }
    .showCustomAlert(type: .confirmationDialog, alert: $showChatSettings)
    .showCustomAlert(alert: $showAlert)
    .showModal($showProfileModal) {
      if let avatar {
        profileModal(avatar: avatar)
      }
    }
    .task {
      await loadAvatar()
    }
  }

}

// MARK: - Subviews

private extension ChatView {

  var scrollViewSection: some View {
    ScrollView {
      LazyVStack(spacing: 24) {
        ForEach(chatMessages) {
          chatBubble($0)
        }
      }
      .frame(maxWidth: .infinity)
      .padding(8)
      .rotationEffect(.degrees(180))
    }
    .rotationEffect(.degrees(180))
    .scrollPosition(id: $scrollPosition, anchor: .center)
    .animation(.default, value: chatMessages.count)
    .animation(.default, value: scrollPosition)
  }

  func chatBubble(_ message: ChatMessageModel) -> some View {
    let isCurrentUser = message.authorId == currentUser?.userId
    return ChatBubbleViewBuilder(
      message: message,
      isCurrentUser: isCurrentUser,
      imageName: isCurrentUser ? nil : avatar?.profileImageName,
      onImagePressed: onAvatarImagePressed
    )
    .id(message.id)
  }

  // MARK: TextField Section

  var textFieldSection: some View {
    TextField("Say something...", text: $textFieldText)
      .keyboardType(.alphabet)
      .autocorrectionDisabled()
      .padding(12)
      .padding(.trailing, 40)
      .overlay(sendMessageButton, alignment: .trailing)
      .background(textFieldBackground)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(Color(uiColor: .secondarySystemBackground))
  }

  var sendMessageButton: some View {
    Image(systemName: "arrow.up.circle.fill")
      .font(.system(size: 32))
      .foregroundStyle(Color.accent)
      .anyButton(action: onSendMessagePressed)
      .padding(.trailing, 4)
  }

  var textFieldBackground: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 100)
        .fill(Color(uiColor: .systemBackground))
      RoundedRectangle(cornerRadius: 100)
        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
    }
  }

  // MARK: Avatar Modal

  private func profileModal(avatar: AvatarModel) -> some View {
    ProfileModalView(
      imageName: avatar.profileImageName,
      title: avatar.name,
      subtitle: avatar.avatarType?.rawValue.capitalized,
      headline: avatar.description,
      onXMarkPressed: { showProfileModal = false}
    )
    .padding(40)
    .transition(.slide)
  }

}

// MARK: - Private functions

private extension ChatView {

  func loadAvatar() async {
    do {
      let avatar = try await avatarManager.getAvatar(id: avatarId)
      self.avatar = avatar
      // ignoring throw since image doesn't have priority
      try? await avatarManager.addRecentAvatar(avatar)
    } catch {
      print("⚠️ Failed to download avatar: \(error.localizedDescription)")
    }
  }

  func onChatSettingsPressed() {
    showChatSettings = AnyAppAlert(
      title: "",
      subtitle: "What would you like to do?",
      buttons: {
        AnyView(
          Group {
            Button("Report User/Chat", role: .destructive) { }
            Button("Delete Chat", role: .destructive) { }
          }
        )
      }
    )
  }

  // MARK: Button actions

  func onAvatarImagePressed() {
    showProfileModal = true
  }

  func onSendMessagePressed() {
    let content = textFieldText

    Task {
      do {
        try TextValidationHelper.textIsValid(content)
        let userMessage = try postUserMessage(content)
        try await postAIResponse()
      } catch {
        showAlert = AnyAppAlert(error: error)
      }
    }
  }

  // MARK: Message functions

  func postUserMessage(_ content: String) throws -> ChatMessageModel {
    try TextValidationHelper.textIsValid(content)
    let message = createChatMessage(content: content, authorId: currentUser?.userId)
    pushMessage(message)
    return message
  }

  func postAIResponse() async throws {
    let aiChat = chatMessages.compactMap { $0.content }
    let response = try await aiManager.generateText(forChat: aiChat)
    let aiMessage = createChatMessage(content: response.message, authorId: avatarId)
    pushMessage(aiMessage)
  }

  func createChatMessage(content: String, authorId: String?) -> ChatMessageModel {
    ChatMessageModel(
      id: UUID().uuidString,
      chatId: UUID().uuidString,
      authorId: authorId,
      content: AIChatModel(role: .user, content: content),
      seenByIds: nil,
      dateCreated: .now
    )
  }

  func pushMessage(_ message: ChatMessageModel) {
    chatMessages.append(message)
    scrollPosition = message.id
    textFieldText = ""
  }

}

// MARK: - Preview

#Preview {
  NavigationStack {
    ChatView()
  }
  .previewEnvironment()
}
