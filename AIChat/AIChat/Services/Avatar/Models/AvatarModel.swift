//
//  AvatarModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import Foundation
import IdentifiableByString

struct AvatarModel: Hashable, Codable, StringIdentifiable {
  var id: String {
    avatarId
  }

  let avatarId: String

  let name: String?
  let avatarType: AvatarType?
  let avatarAction: AvatarAction?
  let avatarLocation: AvatarLocation?
  private(set) var profileImageName: String?
  let authorId: String?
  let dateCreated: Date?

  var description: String {
    AvatarDescriptionBuilder(avatar: self).avatarDescription
  }

  init(
    avatarId: String,
    name: String? = nil,
    avatarType: AvatarType? = nil,
    avatarAction: AvatarAction? = nil,
    avatarLocation: AvatarLocation? = nil,
    profileImageName: String? = nil,
    authorId: String? = nil,
    dateCreated: Date? = nil
  ) {
    self.avatarId = avatarId
    self.name = name
    self.avatarType = avatarType
    self.avatarAction = avatarAction
    self.avatarLocation = avatarLocation
    self.profileImageName = profileImageName
    self.authorId = authorId
    self.dateCreated = dateCreated
  }

  enum CodingKeys: String, CodingKey {
    case avatarId = "avatar_id"
    case name
    case avatarType = "avatar_type"
    case avatarAction = "avatar_action"
    case avatarLocation = "avatar_location"
    case profileImageName = "profile_image_name"
    case authorId = "author_id"
    case dateCreated = "date_created"
  }

  mutating func updateProfileImageName(_ name: String) {
    profileImageName = name
  }

}

// MARK: - Mock data

extension AvatarModel {

  static var mock: Self {
    mocks[Int.random(in: 0..<mocks.count)]
  }

  static var mocks: [Self] {
    [
      AvatarModel(
        avatarId: UUID().uuidString,
        name: "Alpha",
        avatarType: .alien,
        avatarAction: .smiling,
        avatarLocation: .park,
        profileImageName: Constants.randomImage,
        authorId: UUID().uuidString,
        dateCreated: .now
      ),
      AvatarModel(
        avatarId: UUID().uuidString,
        name: "Beta",
        avatarType: .dog,
        avatarAction: .sitting,
        avatarLocation: .store,
        profileImageName: Constants.randomImage,
        authorId: UUID().uuidString,
        dateCreated: .now
      ),
      AvatarModel(
        avatarId: UUID().uuidString,
        name: "Gamma",
        avatarType: .woman,
        avatarAction: .fighting,
        avatarLocation: .forest,
        profileImageName: Constants.randomImage,
        authorId: UUID().uuidString,
        dateCreated: .now
      ),
      AvatarModel(
        avatarId: UUID().uuidString,
        name: "Delta",
        avatarType: .bird,
        avatarAction: .skateboarding,
        avatarLocation: .space,
        profileImageName: Constants.randomImage,
        authorId: UUID().uuidString,
        dateCreated: .now
      )
    ]
  }

}
