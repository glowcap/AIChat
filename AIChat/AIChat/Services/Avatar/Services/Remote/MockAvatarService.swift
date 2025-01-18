//
//  MockAvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import SwiftUI

struct MockAvatarService: RemoteAvatarService {

  let avatars: [AvatarModel]
  let delay: Double
  let showError: Bool

  init(avatars: [AvatarModel] = AvatarModel.mocks, delay: Double = 0.0, showError: Bool = false) {
    self.avatars = avatars
    self.delay = delay
    self.showError = showError
  }

  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws {
    try tryShowError()
  }

  func getAvatar(id: String) async throws -> AvatarModel {
    try tryShowError()
    guard let avatar = avatars.first(where: { $0.avatarId == id }) else {
      throw URLError(.noPermissionsToReadFile)
    }
    try await Task.sleep(for: .seconds(delay))
    return avatar
  }

  func getFeaturedAvatars() async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(delay))
    try tryShowError()
    return avatars.shuffled()
  }

  func getPopularAvatars() async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(delay))
    try tryShowError()
    return avatars.shuffled()
  }

  func getAvatars(category: AvatarType) async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(delay))
    try tryShowError()
    return avatars.shuffled()
  }

  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
    try await Task.sleep(for: .seconds(delay))
    try tryShowError()
    return avatars.sorted(by: {
      ($0.dateCreated ?? .distantPast) > ($1.dateCreated ?? .distantPast)
    })
  }

  func incrementAvatarClickCount(avatarId: String) async throws { }

}

private extension MockAvatarService {

  func tryShowError() throws {
    guard showError else { return }
    throw URLError(.unknown)
  }

}
