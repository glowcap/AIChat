//
//  UserModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct UserModel: Codable {

  /// sharded auth values
  let userId: String
  let email: String?
  let isAnonymous: Bool?
  let creationDate: Date?
  let lastSignInDate: Date?

  /// user only values
  let creationVersion: String?
  let didCompleteOnboarding: Bool?
  let profileColorHex: String?

  var profileColor: Color {
    guard let profileColorHex else { return .accent }
    return .init(hex: profileColorHex)
  }

  init(
    userId: String,
    email: String? = nil,
    isAnonymous: Bool? = nil,
    creationDate: Date? = nil,
    lastSignInDate: Date? = nil,
    creationVersion: String? = nil,
    didCompleteOnboarding: Bool? = nil,
    profileColorHex: String? = nil
  ) {
    self.userId = userId
    self.email = email
    self.isAnonymous = isAnonymous
    self.creationDate = creationDate
    self.lastSignInDate = lastSignInDate
    self.creationVersion = creationVersion
    self.didCompleteOnboarding = didCompleteOnboarding
    self.profileColorHex = profileColorHex
  }

  init(auth: UserAuthInfo, creationVersion: String?) {
    self.init(
      userId: auth.uid,
      email: auth.email,
      isAnonymous: auth.isAnonymous,
      creationDate: auth.creationDate,
      lastSignInDate: auth.lastSignInDate,
      creationVersion: creationVersion
    )
  }

  enum CodingKeys: String, CodingKey {
    case userId = "user_id"
    case email
    case isAnonymous = "is_anonymous"
    case creationDate = "creation_date"
    case creationVersion = "creation_version"
    case lastSignInDate = "last_sign_in_date"
    case didCompleteOnboarding = "did_complete_onboarding"
    case profileColorHex = "profile_color_hex"
  }

}

// MARK: - Mock data

extension UserModel {

  static var mock: Self {
    mocks[0]
  }

  static var mocks: [Self] {
    [
      UserModel(
        userId: "user1",
        creationDate: .now.addingTimeInterval(days: -365),
        didCompleteOnboarding: true,
        profileColorHex: "#00B98E"
      ),
      UserModel(
        userId: "user2",
        creationDate: .now.addingTimeInterval(days: -25),
        didCompleteOnboarding: false,
        profileColorHex: "#33FF57"
      ),
      UserModel(
        userId: "user3",
        creationDate: .now.addingTimeInterval(hours: -5),
        didCompleteOnboarding: true,
        profileColorHex: "#3357FF"
      ),
      UserModel(
        userId: "user4",
        creationDate: .now.addingTimeInterval(days: -1),
        didCompleteOnboarding: true,
        profileColorHex: "#FFC300"
      )
    ]
  }

}
