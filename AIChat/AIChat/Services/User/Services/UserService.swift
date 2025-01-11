//
//  UserService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/11/25.
//

import Foundation

protocol UserService {
  func saveUser(user: UserModel) throws
}
