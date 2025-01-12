//
//  MockUserPersistence.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import Foundation

struct MockUserPersistence: LocalUserPersistence {
  let currentUser: UserModel?

  init(user: UserModel? = nil) {
    self.currentUser = user
  }

  func getCurrentUser() -> UserModel? {
    currentUser
  }

  func saveCurrentUser(user: UserModel?) throws { }
}
