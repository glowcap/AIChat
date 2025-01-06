//
//  ChatsView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ChatsView: View {

  @State private var chats: [ChatModel] = ChatModel.mocks
  @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks

  @State private var path: [NavigationPathOption] = []

  var body: some View {
    NavigationStack(path: $path) {
      List {
        if !recentAvatars.isEmpty {
          recentsSection
        }
        chatsSection
      }
      .navigationTitle("Chats")
      .coreModuleNavigationDestination(path: $path)
    }
  }

}

// MARK: - Subviews

private extension ChatsView {

  var recentsSection: some View {
    Section {
      ScrollView(.horizontal) {
        LazyHStack(spacing: 8) {
          ForEach(recentAvatars, id: \.self) { avatar in
            if let imageName = avatar.profileImageName {
              VStack(spacing: 8) {
                ImageLoaderView(urlString: imageName)
                  .aspectRatio(1, contentMode: .fit)
                  .clipShape(Circle())
                Text(avatar.name ?? "")
                  .font(.caption)
                  .foregroundStyle(.secondary)
              }
              .anyButton {
                onRecentAvatarPressed(avatar: avatar)
              }
            }
          }
        }
      }
      .frame(height: 120)
      .scrollIndicators(.hidden)
      .removeListRowFormatting()
    } header: {
      Text("Recents")
    }
  }

  var chatsSection: some View {
    Section {
      if chats.isEmpty {
        emptyChats
      } else {
        currentUserChats
      }
    } header: {
      Text("Chats")
    }
  }

  var currentUserChats: some View {
    ForEach(chats) { chat in
      ChatRowCellViewBuilder(
        currentUserId: nil, // add cuid
        chat: chat,
        getAvatar: {
          try? await Task.sleep(for: .seconds(1))
          return .mock
        },
        getLastMessage: {
          try? await Task.sleep(for: .seconds(1))
          return .mock
        }
      )
      .anyButton(.highlight) {
        onChatPressed(chat: chat)
      }
      .removeListRowFormatting()
    }
  }

  var emptyChats: some View {
    Text("Your chats will appear here")
      .foregroundStyle(.secondary)
      .font(.title3)
      .frame(maxWidth: .infinity)
      .multilineTextAlignment(.center)
      .padding(40)
      .removeListRowFormatting()
  }

}

// MARK: - Private functions

private extension ChatsView {

  func onChatPressed(chat: ChatModel) {
    path.append(.chat(avatarId: chat.avatarId))
  }

  func onRecentAvatarPressed(avatar: AvatarModel) {
    path.append(.chat(avatarId: avatar.avatarId))
  }

}

#Preview {
  ChatsView()
}
