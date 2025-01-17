//
//  MockAvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import SwiftUI

struct MockAvatarService: RemoteAvatarService {
  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws { }

  func getAvatar(id: String) async throws -> AvatarModel {
    try await Task.sleep(for: .seconds(1))
    return AvatarModel.mock
  }

  func getFeaturedAvatars() async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(2))
    return AvatarModel.mocks.shuffled()
  }

  func getPopularAvatars() async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(1))
    return AvatarModel.mocks.shuffled()
  }

  func getAvatars(category: AvatarType) async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(1))
    return AvatarModel.mocks.shuffled()
  }

  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(1))
    return AvatarModel.mocks.shuffled()
  }

}
