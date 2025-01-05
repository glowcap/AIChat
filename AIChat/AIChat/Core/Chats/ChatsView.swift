//
//  ChatsView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ChatsView: View {

  @State private var chats: [ChatModel] = ChatModel.mocks

  @State private var path: [NavigationPathOption] = []

  var body: some View {
    NavigationStack(path: $path) {
      List {
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
      .navigationTitle("Chats")
      .coreModuleNavigationDestination(path: $path)
    }
  }

}

// MARK: - Private functions

private extension ChatsView {

  func onChatPressed(chat: ChatModel) {
    path.append(.chat(avatarId: chat.avatarId))
  }

}

#Preview {
  ChatsView()
}
