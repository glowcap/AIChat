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

  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        LazyVStack(spacing: 24) {
          ForEach(chatMessages) {
            chatBubble($0)
          }
        }
        .frame(maxWidth: .infinity)
        .padding(8)
      }

      Rectangle()
        .frame(height: 50)
    }
    .navigationTitle(avatar?.name ?? "Chat")
  }

}

// MARK: - Subviews

private extension ChatView {

  func chatBubble(_ message: ChatMessageModel) -> some View {
    let isCurrentUser = message.authorId == currentUser?.userId
    return ChatBubbleViewBuilder(
      message: message,
      isCurrentUser: isCurrentUser,
      imageName: isCurrentUser ? nil : avatar?.profileImageName
    )
  }

}

#Preview {
  NavigationStack {
    ChatView()
  }
}
