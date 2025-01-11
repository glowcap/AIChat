//
//  UserManager.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import SwiftUI


@MainActor
@Observable
class UserManager {

  private let service: UserService

  private(set) var currentUser: UserModel?

  init(service: UserService) {
    self.service = service
    self.currentUser = nil
  }

  func logIn(auth: AuthInfo) throws {
    let creationVersion = auth.isNewUser ? Bundle.main.appVersion : nil
    let user = UserModel(auth: auth.user, creationVersion: creationVersion)

    try service.saveUser(user: user)
  }

}
