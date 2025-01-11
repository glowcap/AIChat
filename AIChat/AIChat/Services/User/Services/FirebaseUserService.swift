//
//  FirebaseUserService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import FirebaseFirestore
import Foundation

struct FirebaseUserService: UserService {

  var collection: CollectionReference = Firestore.firestore().collection("users")

  func saveUser(user: UserModel) throws {
    try collection.document(user.userId).setData(from: user, merge: true)
  }

}
