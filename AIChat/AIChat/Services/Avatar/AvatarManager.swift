//
//  AvatarManager.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/14/25.
//

import SwiftUI

@MainActor
@Observable
class AvatarManager {

  private let service: AvatarService

  init(service: AvatarService) {
    self.service = service
  }

  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws {
    try await service.createAvatar(avatar, image: image)
  }

}
