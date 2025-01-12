//
//  FileManagerLocalUserPersistence.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import Foundation

struct FileManagerUserPersistence: LocalUserPersistence {
  private let userDocumentKey = "current_user"

  func getCurrentUser() -> UserModel? {
    try? FileManager.getDocument(key: userDocumentKey)
  }

  func saveCurrentUser(user: UserModel?) throws {
    try FileManager.saveDocument(key: userDocumentKey, value: user)
  }
}
