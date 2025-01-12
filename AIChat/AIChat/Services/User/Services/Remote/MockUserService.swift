//
//  MockUserService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import Foundation
import FirebaseFirestore

struct MockUserService: RemoteUserService {

  let currentUser: UserModel?

  init(user: UserModel? = nil) {
    currentUser = user
  }

  func saveUser(user: UserModel) throws {

  }

  func deleteUser(userId: String) async throws {

  }

  func markOnboardingCompleted(userId: String, profileHexColor: String) async throws {

  }

  func streamUser(
    userId: String,
    onListenerConfigured: @escaping (any ListenerRegistration) -> Void
  ) -> AsyncThrowingStream<UserModel, any Error> {
    AsyncThrowingStream { continuation in
      if let currentUser { continuation.yield(currentUser) }
    }
  }

}
