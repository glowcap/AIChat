//
//  ChatsView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ChatsView: View {

  @State private var chats: [ChatModel] = ChatModel.mocks

  var body: some View {
    NavigationStack {
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
          .anyButton(.highlight, action: {
            // on tap action
          })
          .removeListRowFormatting()
        }
      }
      .navigationTitle("Chats")
    }
  }
}

#Preview {
  ChatsView()
}
