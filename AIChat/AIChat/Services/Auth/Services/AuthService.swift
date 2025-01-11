//
//  AuthService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/9/25.
//

import SwiftUI

protocol AuthService: Sendable {

  func addAuthenticatedUserListener(
    onListenerAttached: (any NSObjectProtocol) -> Void
  ) -> AsyncStream<UserAuthInfo?>

  func getAuthenticatedUser() -> UserAuthInfo?
  func signInAnonymously() async throws -> AuthInfo
  func signInApple() async throws -> AuthInfo
  func signOut() throws
  func deleteAccount() async throws

}
