//
//  ProductionUserServices.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import Foundation

struct ProductionUserServices: UserServices {
  let remote: RemoteUserService =  FirebaseUserService()
  let local: LocalUserPersistence = FileManagerUserPersistence()
}
