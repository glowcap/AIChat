//
//  AvatarDescriptionBuilder.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import Foundation

struct AvatarDescriptionBuilder {
  let avatarType: AvatarType
  let avatarAction: AvatarAction
  let avatarLocation: AvatarLocation

  init(avatarType: AvatarType, avatarAction: AvatarAction, avatarLocation: AvatarLocation) {
    self.avatarType = avatarType
    self.avatarAction = avatarAction
    self.avatarLocation = avatarLocation
  }

  init(avatar: AvatarModel) {
    self.avatarType = avatar.avatarType ?? .default
    self.avatarAction = avatar.avatarAction ?? .default
    self.avatarLocation = avatar.avatarLocation ?? .default
  }

  var avatarDescription: String {
    let prefix = avatarType.startsWithVowel ? "An" : "A"
    return "\(prefix) \(avatarType.rawValue) that is \(avatarAction.rawValue) in the \(avatarLocation.rawValue)"
  }

}
