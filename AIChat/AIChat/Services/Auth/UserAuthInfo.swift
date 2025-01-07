//
//  UserAuthInfo.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/7/25.
//

import FirebaseAuth
import SwiftUI

struct UserAuthInfo: Sendable {
  let uid: String
  let email: String?
  let isAnonymous: Bool
  let creationDate: Date?
  let lastSignInDate: Date?

  init(
    uid: String,
    email: String? = nil,
    isAnonymous: Bool = false,
    creationDate: Date? = nil,
    lastSignInDate: Date? = nil
  ) {
    self.uid = uid
    self.email = email
    self.isAnonymous = isAnonymous
    self.creationDate = creationDate
    self.lastSignInDate = lastSignInDate
  }

  init(user: User) {
    self.uid = user.uid
    self.email = user.email
    self.isAnonymous = user.isAnonymous
    self.creationDate = user.metadata.creationDate
    self.lastSignInDate = user.metadata.lastSignInDate
  }

}