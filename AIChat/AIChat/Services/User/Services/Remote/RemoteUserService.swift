//
//  UserService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import Foundation
import FirebaseFirestore

protocol RemoteUserService: Sendable {
  func saveUser(user: UserModel) throws
  func deleteUser(userId: String) async throws
  func markOnboardingCompleted(userId: String, profileHexColor: String) async throws
  func streamUser(
    userId: String,
    onListenerConfigured: @escaping (ListenerRegistration) -> Void
  ) -> AsyncThrowingStream<UserModel, Error>
}
