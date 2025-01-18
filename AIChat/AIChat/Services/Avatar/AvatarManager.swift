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

  private let remote: RemoteAvatarService
  private let local: LocalAvatarPersistence

  init(remote: RemoteAvatarService, local: LocalAvatarPersistence) {
    self.remote = remote
    self.local = local
  }

  func addRecentAvatar(_ avatar: AvatarModel) async throws {
    try local.addRecentAvatar(avatar)
    try await remote.incrementAvatarClickCount(avatarId: avatar.avatarId)
  }

  func getRecentAvatars() throws -> [AvatarModel] {
    try local.getRecentAvatars()
  }

  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws {
    try await remote.createAvatar(avatar, image: image)
  }

  func getAvatar(id: String) async throws -> AvatarModel {
    try await remote.getAvatar(id: id)
  }

  func getFeaturedAvatars() async throws -> [AvatarModel] {
    try await remote.getFeaturedAvatars()
  }

  func getPopularAvatars() async throws -> [AvatarModel] {
    try await remote.getPopularAvatars()
  }

  func getAvatars(category: AvatarType) async throws -> [AvatarModel] {
    try await remote.getAvatars(category: category)
  }

  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
    try await remote.getAvatarsForAuthor(userId: userId)
  }

}
