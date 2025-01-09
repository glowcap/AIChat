//
//  AuthService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/9/25.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var authService: AuthService = MockAuthService()
}

protocol AuthService: Sendable {
  typealias AuthInfo = (user: UserAuthInfo, isNewUser: Bool)

  func getAuthenticatedUser() -> UserAuthInfo?
  func signInAnonymously() async throws -> AuthInfo
  func signInApple() async throws -> AuthInfo
  func signOut() throws
  func deleteAccount() async throws

}
