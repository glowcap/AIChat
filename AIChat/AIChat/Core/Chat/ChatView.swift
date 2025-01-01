//
//  ChatView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import SwiftUI

struct ChatView: View {

  @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
  @State private var avatar: AvatarModel? = .mock
  @State private var currentUser: UserModel? = .mock
  @State private var textFieldText: String = ""

  @State private var showChatSettings: Bool = false
  @State private var scrollPosition: String?

  var body: some View {
    VStack(spacing: 0) {
      scrollViewSection
      textFieldSection
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
    .confirmationDialog(
      "",
      isPresented: $showChatSettings,
      actions: {
        Button("Report User/Chat", role: .destructive, action: {})
        Button("Delete Chat", role: .destructive, action: {})
      }, message: {
        Text("What would you like do?")
      }
    )
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
      imageName: isCurrentUser ? nil : avatar?.profileImageName
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

}

// MARK: - Private functions

private extension ChatView {

  func onSendMessagePressed() {
    let content = textFieldText

    let message = ChatMessageModel(
      id: UUID().uuidString,
      chatId: UUID().uuidString,
      authorId: currentUser?.userId,
      content: content,
      seenByIds: nil,
      dateCreated: .now
    )
    chatMessages.append(message)
    scrollPosition = message.id
    textFieldText = ""
  }

  func onChatSettingsPressed() {
    showChatSettings = true
  }

}

// MARK: - Preview

#Preview {
  NavigationStack {
    ChatView()
  }
}
