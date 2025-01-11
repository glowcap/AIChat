//
//  UserManager.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
@Observable
class UserManager {

  private let service: UserService

  private(set) var currentUser: UserModel?

  private var currentUserListener: ListenerRegistration?

  init(service: UserService) {
    self.service = service
    self.currentUser = nil
  }

  func logIn(auth: AuthInfo) throws {
    let creationVersion = auth.isNewUser ? Bundle.main.appVersion : nil
    let user = UserModel(auth: auth.user, creationVersion: creationVersion)

    try service.saveUser(user: user)
    addCurrentUserListener(userId: user.userId)
  }

  func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
    try await service.markOnboardingCompleted(
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
    try await service.deleteUser(userId: currentUserId())
    signOut()
  }

}

// MARK: - Private functions

private extension UserManager {

  func addCurrentUserListener(userId: String) {
    currentUserListener?.remove()

    Task {
      do {
        for try await value in service.streamUser(
          userId: userId,
          onListenerConfigured: { self.currentUserListener = $0 }
        ) {
          self.currentUser = value
          print("👂👤 User listener set: \(value.userId)")
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

}

// MARK: - UserManagerError

extension UserManager {

  enum UserManagerError: LocalizedError {
    case noUserId
  }

}
