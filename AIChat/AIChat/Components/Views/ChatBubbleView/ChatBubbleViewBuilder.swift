//
//  ChatBubbleViewBuilder.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {

  var message: ChatMessageModel = .mock
  var isCurrentUser: Bool = false
  var imageName: String?
  var onImagePressed: (() -> Void)?

  var body: some View {
    ChatBubbleView(
      text: message.content ?? "",
      textColor: isCurrentUser ? .white : .primary,
      backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray5),
      showImage: !isCurrentUser,
      imageName: imageName,
      onImagePressed: onImagePressed
    )
    .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
    .padding(isCurrentUser ? .leading : .trailing, 75)
  }

}

#Preview {
  // swiftlint:disable line_length
  ScrollView {
    VStack(spacing: 24) {
      ChatBubbleViewBuilder()
      ChatBubbleViewBuilder(isCurrentUser: true)
      ChatBubbleViewBuilder()
      ChatBubbleViewBuilder(
        message: ChatMessageModel(
          id: UUID().uuidString,
          chatId: UUID().uuidString,
          authorId: UUID().uuidString,
          content: "This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines. This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines.",
          seenByIds: [],
          dateCreated: .now
        ),
        isCurrentUser: true,
        imageName: nil
      )
      ChatBubbleViewBuilder(
        message: ChatMessageModel(
          id: UUID().uuidString,
          chatId: UUID().uuidString,
          authorId: UUID().uuidString,
          content: "This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines. This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines.This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines. This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines.",
          seenByIds: [],
          dateCreated: .now
        ),
        isCurrentUser: false,
        imageName: Constants.randomImage
      )
    }
  }
  .padding(8)
  // swiftlint:enable line_length
}
