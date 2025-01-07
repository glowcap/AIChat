//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/7/25.
//

import FirebaseAuth
import SwiftUI

extension EnvironmentValues {
  @Entry var authService: FirebaseAuthService = .init()
}

struct FirebaseAuthService {

  func getAuthenticatedUser() -> UserAuthInfo? {
    if let user = Auth.auth().currentUser {
      return UserAuthInfo(user: user)
    }
    return nil
  }

  func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
    let result = try await Auth.auth().signInAnonymously()
    let user = UserAuthInfo(user: result.user)
    let isNewUser = result.additionalUserInfo?.isNewUser ?? true

    return (user, isNewUser)
  }

}
