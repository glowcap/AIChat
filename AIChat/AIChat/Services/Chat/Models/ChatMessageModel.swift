//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import Foundation

struct ChatMessageModel: Identifiable {
  let id: String
  let chatId: String
  let authorId: String?
  let content: AIChatModel?
  let seenByIds: [String]?
  let dateCreated: Date?

  init(
    id: String,
    chatId: String,
    authorId: String? = nil,
    content: AIChatModel? = nil,
    seenByIds: [String]? = nil,
    dateCreated: Date? = nil
  ) {
    self.id = id
    self.chatId = chatId
    self.authorId = authorId
    self.content = content
    self.seenByIds = seenByIds
    self.dateCreated = dateCreated
  }

  func seenBy(userId: String) -> Bool {
    guard let seenByIds else { return false }
    return seenByIds.contains(userId)
  }

}

// MARK: - Mock data

extension ChatMessageModel {

  static var mock: ChatMessageModel {
    mocks[0]
  }
  // swiftlint:disable line_length
  static var mocks: [ChatMessageModel] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"

    return [
      ChatMessageModel(
        id: "msg_1",
        chatId: "mock_chat_1",
        authorId: "user1",
        content: AIChatModel(role: .user, content: "How's it going, homie?"),
        seenByIds: ["user2", "user1"],
        dateCreated: dateFormatter.date(from: "2024/01/01 10:15")
      ),
      ChatMessageModel(
        id: "msg_2",
        chatId: "mock_chat_1",
        authorId: "user2",
        content: AIChatModel(role: .assistant, content: "Not too bad. Work sucks, but that's nothing new"),
        seenByIds: ["user1", "user2"],
        dateCreated: dateFormatter.date(from: "2024/01/01 10:30")
      ),
      ChatMessageModel(
        id: "msg_3",
        chatId: "mock_chat_1",
        authorId: "user1",
        content: AIChatModel(role: .user, content: "💯 There's always a fire to put out. Last week, we had a sudden ask from the C-levels and had to drop everything to get it in before code freeze. It was really just a want, but required features and bug fixes still needed to get in as well. The development team ended up working over the weekend. But hey, they said thanks and probably raised the bar for our ticket count for future sprints"),
        seenByIds: ["user1, user2"],
        dateCreated: dateFormatter.date(from: "2024/03/10 14:00")
      ),
      ChatMessageModel(
        id: "msg_4",
        chatId: "mock_chat_1",
        authorId: "user2",
        content: AIChatModel(role: .assistant, content: "Sorry to hear that, but I'm not really here to listen to you complain 🫠"),
        seenByIds: ["user2"],
        dateCreated: dateFormatter.date(from: "2024/04/12 16:45")
      )
    ]
  }
  // swiftlint:enable line_length
}
