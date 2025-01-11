//
//  MockAuthService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/9/25.
//

import Foundation

struct MockAuthService: AuthService {

  let currentUser: UserAuthInfo?

  init(user: UserAuthInfo? = nil) {
    currentUser = user
  }

  func addAuthenticatedUserListener(
    onListenerAttached: (any NSObjectProtocol) -> Void
  ) -> AsyncStream<UserAuthInfo?> {
    AsyncStream { continuation in
      continuation.yield(currentUser)
    }
  }

  func getAuthenticatedUser() -> UserAuthInfo? {
    currentUser
  }

  func signInAnonymously() async throws -> AuthInfo {
    let user = UserAuthInfo.mock(isAnonymous: true)
    return AuthInfo(user: user, isNewUser: true)
  }

  func signInApple() async throws -> AuthInfo {
    let user = UserAuthInfo.mock()
    return AuthInfo(user: user, isNewUser: false)
  }

  func signOut() throws { }

  func deleteAccount() async throws { }

}