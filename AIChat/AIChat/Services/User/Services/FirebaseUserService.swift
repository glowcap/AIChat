//
//  FirebaseUserService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import FirebaseFirestore
import Foundation
import SwiftfulFirestore

struct FirebaseUserService: UserService {

  var collection: CollectionReference = Firestore.firestore().collection("users")

  func saveUser(user: UserModel) throws {
    try collection.document(user.userId).setData(from: user, merge: true)
  }

  func markOnboardingCompleted(userId: String, profileHexColor: String) async throws {
    try await collection.document(userId).updateData([
      UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
      UserModel.CodingKeys.profileColorHex.rawValue: profileHexColor
    ])
  }

  func streamUser(
    userId: String,
    onListenerConfigured: @escaping (ListenerRegistration) -> Void
  ) -> AsyncThrowingStream<UserModel, Error> {
    collection.streamDocument(id: userId, onListenerConfigured: onListenerConfigured)
  }

  func deleteUser(userId: String) async throws {
    try await collection.document(userId).delete()
  }

}
