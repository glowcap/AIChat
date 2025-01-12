//
//  LocalUserPersistence.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

protocol LocalUserPersistence {

  func getCurrentUser() -> UserModel?
  func saveCurrentUser(user: UserModel?) throws

}
