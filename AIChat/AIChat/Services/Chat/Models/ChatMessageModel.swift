//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import Foundation

struct ChatMessageModel {
  let id: String
  let chatId: String
  let authorId: String?
  let content: String?
  let seenByIds: [String]?
  let dateCreated: Date?

  init(
    id: String,
    chatId: String,
    authorId: String? = nil,
    content: String? = nil,
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

  static var mocks: [ChatMessageModel] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"

    return [
         ChatMessageModel(
           id: "msg_1",
           chatId: "mock_chat_1",
           authorId: "user1",
           content: "Hello, how are you?",
           seenByIds: ["user2", "user3"],
           dateCreated: dateFormatter.date(from: "2024/01/01 10:15")
         ),
         ChatMessageModel(
           id: "msg_2",
           chatId: "mock_chat_1",
           authorId: "user2",
           content: "I'm doing well, thanks! And you?",
           seenByIds: ["user1", "user3"],
           dateCreated: dateFormatter.date(from: "2024/01/01 10:30")
         ),
         ChatMessageModel(
           id: "msg_3",
           chatId: "mock_chat_1",
           authorId: "user3",
           content: "Hey! Long time no see.",
           seenByIds: ["user4"],
           dateCreated: dateFormatter.date(from: "2024/03/10 14:00")
         ),
         ChatMessageModel(
           id: "msg_4",
           chatId: "mock_chat_1",
           authorId: "user4",
           content: "Hi everyone! I just joined.",
           seenByIds: ["user1", "user2"],
           dateCreated: dateFormatter.date(from: "2024/04/12 16:45")
         )
       ]
  }
}
