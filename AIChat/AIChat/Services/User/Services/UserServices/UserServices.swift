//
//  UserServices.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import Foundation

protocol UserServices {
  var remote: RemoteUserService { get }
  var local: LocalUserPersistence { get }
}
