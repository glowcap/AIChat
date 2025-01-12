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

  private let remote: RemoteUserService
  private let local: LocalUserPersistence

  private(set) var currentUser: UserModel?

  private var currentUserListener: ListenerRegistration?

  init(services: UserServices) {
    self.remote = services.remote
    self.local = services.local
    self.currentUser = local.getCurrentUser()
  }

  func logIn(auth: AuthInfo) throws {
    let creationVersion = auth.isNewUser ? Bundle.main.appVersion : nil
    let user = UserModel(auth: auth.user, creationVersion: creationVersion)

    try remote.saveUser(user: user)
    addCurrentUserListener(userId: user.userId)
  }

  func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
    try await remote.markOnboardingCompleted(
      userId: currentUserId(),
      profileHexColor: profileColorHex
    )
  }

  func signOut() {
    currentUserListener?.remove()
    currentUserListener = nil
    currentUser = nil
  }

  func deleteCurrentUser() async throws {
    try await remote.deleteUser(userId: currentUserId())
    signOut()
  }

}

// MARK: - Private functions

private extension UserManager {

  func addCurrentUserListener(userId: String) {
    currentUserListener?.remove()

    Task {
      do {
        for try await value in remote.streamUser(
          userId: userId,
          onListenerConfigured: { self.currentUserListener = $0 }
        ) {
          self.currentUser = value
          print("👂👤 User listener set: \(value.userId)")
          try self.local.saveCurrentUser(user: value)
        }
      } catch {
        print("⛔️ Attach user listener failed: \(error.localizedDescription)")
      }
    }
  }

  func currentUserId() throws -> String {
    guard let uid = currentUser?.userId else {
      throw UserManagerError.noUserId
    }
    return uid
  }

  func persistCurrrentUser() {
    Task {
      do {
        try local.saveCurrentUser(user: currentUser)
      } catch {
        print("⛔️ Failed to persist current user: \(error.localizedDescription)")
      }
    }
  }

}

// MARK: - UserManagerError

extension UserManager {

  enum UserManagerError: LocalizedError {
    case noUserId
  }

}
