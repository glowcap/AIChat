//
//  AvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import SwiftUI

protocol AvatarService: Sendable {
  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws
  func getFeaturedAvatars() async throws -> [AvatarModel]
  func getPopularAvatars() async throws -> [AvatarModel]
  func getAvatars(category: AvatarType) async throws -> [AvatarModel]
  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] 
}
