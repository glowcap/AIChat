//
//  MockUserServices.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import Foundation

struct MockUserServices: UserServices {
  let remote: RemoteUserService
  let local: LocalUserPersistence

  init(user: UserModel? = nil) {
    self.remote = MockUserService(user: user)
    self.local = MockUserPersistence(user: user)
  }
}
