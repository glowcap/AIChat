//
//  AvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import SwiftUI

protocol RemoteAvatarService: Sendable {
  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws
  func getAvatar(id: String) async throws -> AvatarModel
  func getFeaturedAvatars() async throws -> [AvatarModel]
  func getPopularAvatars() async throws -> [AvatarModel]
  func getAvatars(category: AvatarType) async throws -> [AvatarModel]
  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel]
  func incrementAvatarClickCount(avatarId: String) async throws
  func removeAuthorIdFromAvatar(avatarId: String) async throws
  func removeAuthorIdFromAllAvatars(userId: String) async throws
}
