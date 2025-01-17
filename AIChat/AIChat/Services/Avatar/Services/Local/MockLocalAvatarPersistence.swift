//
//  MockLocalAvatarPersistence.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/17/25.
//

import Foundation

struct MockLocalAvatarPersistence: LocalAvatarPersistence {

  func addRecentAvatar(_ avatar: AvatarModel) throws { }

  func getRecentAvatars() throws -> [AvatarModel] {
    AvatarModel.mocks.shuffled()
  }

}
