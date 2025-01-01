//
//  ChatRowCellViewBuilder.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {

  var currentUserId: String? = ""
  var chat: ChatModel = .mock
  var getAvatar: () async -> AvatarModel?
  var getLastMessage: () async -> ChatMessageModel?

  @State private var avatar: AvatarModel?
  @State private var lastMessage: ChatMessageModel?

  @State private var didLoadAvatar: Bool = false
  @State private var didLoadLastMessage: Bool = false

  private var isLoading: Bool {
    !(didLoadAvatar && didLoadLastMessage)
  }

  private var hasNewChat: Bool {
    guard let lastMessage,
          let currentUserId
    else { return false }
    return lastMessage.seenBy(userId: currentUserId)
  }

  private var subheadline: String? {
    if isLoading {
      return "xxx xxxxx xx xxxx"
    }
    if avatar == nil, lastMessage == nil {
      return "Last message not found"
    }
    return lastMessage?.content
  }

  var body: some View {
    ChatRowCellView(
      imageName: avatar?.profileImageName,
      headline: isLoading ? "xxxxxxx" : avatar?.name,
      subheadline: subheadline,
      hasNewChat: hasNewChat
    )
    .redacted(reason: isLoading ? .placeholder : [])
    .task {
      avatar = await getAvatar()
      didLoadAvatar = true
    }
    .task {
      lastMessage = await getLastMessage()
      didLoadLastMessage = true
    }
  }

}

#Preview {
  List {
    ChatRowCellViewBuilder(
      chat: .mock,
      getAvatar: {
        try? await Task.sleep(for: .seconds(2))
        return .mock
      },
      getLastMessage: {
        try? await Task.sleep(for: .seconds(2))
        return .mock
      }
    )
    .removeListRowFormatting()

    ChatRowCellViewBuilder(chat: .mock) {
      .mock
    } getLastMessage: {
      .mock
    }
    .removeListRowFormatting()

    ChatRowCellViewBuilder(chat: .mock) {
      nil
    } getLastMessage: {
      nil
    }
    .removeListRowFormatting()

  }
}
