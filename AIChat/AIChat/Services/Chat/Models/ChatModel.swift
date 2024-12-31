//
//  ChatModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import Foundation

struct ChatModel: Identifiable {
  let id: String
  let userId: String
  let avatarId: String
  let dateCreated: Date
  let dateModified: Date
}

// MARK: - Mock data

extension ChatModel {

  static var mock: Self {
    mocks[0]
  }

  static var mocks: [Self] {
    let chat1Start = Date(timeIntervalSince1970: 1622505600)  // June 1, 2021
    let chat2Start = Date(timeIntervalSince1970: 1625097600)  // July 1, 2021
    let chat3Start = Date(timeIntervalSince1970: 1627776000)  // August 1, 2021
    let chat4Start = Date(timeIntervalSince1970: 1630454400)  // September 1, 2021

    return [
      ChatModel(
        id: "mock_chat_1",
        userId: "user_1",
        avatarId: "avatar_1",
        dateCreated: chat1Start,
        dateModified: chat1Start.addingTimeInterval(days: 1)
      ),
      ChatModel(
        id: "mock_chat_2",
        userId: "user_2",
        avatarId: "avatar_2",
        dateCreated: chat2Start,
        dateModified: chat2Start.addingTimeInterval(hours: 3)
      ),
      ChatModel(
        id: "mock_chat_3",
        userId: "user_3",
        avatarId: "avatar_3",
        dateCreated: chat3Start,
        dateModified: chat3Start.addingTimeInterval(hours: 1, minutes: 10)
      ),
      ChatModel(
        id: "mock_chat_4",
        userId: "user_4",
        avatarId: "avatar_4",
        dateCreated: chat4Start,
        dateModified: chat4Start.addingTimeInterval(minutes: 5)
      )
    ]
  }
}
