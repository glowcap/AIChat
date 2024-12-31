//
//  UserModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct UserModel {
  let userId: String
  let dateCreated: Date?
  let didCompleteOnboarding: Bool?
  let profileColorHex: String?

  var profileColor: Color {
    guard let profileColorHex else { return .accent }
    return .init(hex: profileColorHex)
  }

  init(
    userId: String,
    dateCreated: Date? = nil,
    didCompleteOnboarding: Bool? = nil,
    profileColorHex: String?
  ) {
    self.userId = userId
    self.dateCreated = dateCreated
    self.didCompleteOnboarding = didCompleteOnboarding
    self.profileColorHex = profileColorHex
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
        dateCreated: .now.addingTimeInterval(days: -365),
        didCompleteOnboarding: true,
        profileColorHex: "#00B98E"
      ),
      UserModel(
        userId: "user2",
        dateCreated: .now.addingTimeInterval(days: -25),
        didCompleteOnboarding: false,
        profileColorHex: "#33FF57"
      ),
      UserModel(
        userId: "user3",
        dateCreated: .now.addingTimeInterval(hours: -5),
        didCompleteOnboarding: true,
        profileColorHex: "#3357FF"
      ),
      UserModel(
        userId: "user4",
        dateCreated: .now.addingTimeInterval(days: -1),
        didCompleteOnboarding: true,
        profileColorHex: "#FFC300"
      )
    ]
  }

}
