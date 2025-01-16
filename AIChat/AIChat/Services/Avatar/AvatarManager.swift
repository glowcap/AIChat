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

  func getFeaturedAvatars() async throws -> [AvatarModel] {
    try await service.getFeaturedAvatars()
  }

  func getPopularAvatars() async throws -> [AvatarModel] {
    try await service.getPopularAvatars()
  }

  func getAvatars(category: AvatarType) async throws -> [AvatarModel] {
    try await service.getAvatars(category: category)
  }

  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
    try await service.getAvatarsForAuthor(userId: userId)
  }

}
