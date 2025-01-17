//
//  AvatarEntity.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/17/25.
//

import Foundation
import SwiftData

@Model
final class AvatarEntity {

  @Attribute(.unique) var avatarId: String

  var name: String?
  var avatarType: AvatarType?
  var avatarAction: AvatarAction?
  var avatarLocation: AvatarLocation?
  var profileImageName: String?
  var authorId: String?
  var dateCreated: Date?
  var dateAdded: Date

  init(from model: AvatarModel) {
    self.avatarId = model.avatarId
    self.name = model.name
    self.avatarType = model.avatarType
    self.avatarAction = model.avatarAction
    self.avatarLocation = model.avatarLocation
    self.profileImageName = model.profileImageName
    self.authorId = model.authorId
    self.dateCreated = model.dateCreated
    self.dateAdded = .now
  }

  func toModel() -> AvatarModel {
    AvatarModel(
      avatarId: avatarId,
      name: name,
      avatarType: avatarType,
      avatarAction: avatarAction,
      avatarLocation: avatarLocation,
      profileImageName: profileImageName,
      authorId: authorId,
      dateCreated: dateCreated
    )
  }

}
