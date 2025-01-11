//
//  AuthManager.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/10/25.
//

import SwiftUI

@MainActor
@Observable
class AuthManager {

  private let service: AuthService

  private(set) var auth: UserAuthInfo?

  private var listener: (any NSObjectProtocol)?

  init(service: AuthService) {
    self.service = service
    self.auth = service.getAuthenticatedUser()
    self.addAuthListener()
  }

  func getAuthId() throws -> String {
    guard let uid = auth?.uid else {
      throw AuthError.notSignedIn
    }
    return uid
  }

  func signInAnonymously() async throws -> AuthInfo {
    try await service.signInAnonymously()
  }

  func signInApple() async throws -> AuthInfo {
    try await service.signInApple()
  }

  func signOut() throws {
    try service.signOut()
    auth = nil
  }

  func deleteAccount() async throws {
    try await service.deleteAccount()
    auth = nil
  }

}

// MARK: - Private functions

private extension AuthManager {

  func addAuthListener() {
    Task {
      for await value in service
        .addAuthenticatedUserListener(onListenerAttached: { self.listener = $0 }) {
          self.auth = value
        print("👂🔐 Auth listener success: \(value?.uid ?? "no uid")")
      }
    }
  }

}

// MARK: - AuthManager Error

extension AuthManager {

  enum AuthError: LocalizedError {
    case notSignedIn
  }

}
