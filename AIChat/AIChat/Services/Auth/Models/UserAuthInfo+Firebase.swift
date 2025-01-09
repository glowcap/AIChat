//
//  UserAuthInfo+Firebase.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/7/25.
//

import FirebaseAuth
import Foundation

extension UserAuthInfo {

  init(user: User) {
    self.uid = user.uid
    self.email = user.email
    self.isAnonymous = user.isAnonymous
    self.creationDate = user.metadata.creationDate
    self.lastSignInDate = user.metadata.lastSignInDate
  }

}
