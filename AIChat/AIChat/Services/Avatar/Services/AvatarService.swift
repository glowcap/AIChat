//
//  AvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import SwiftUI

protocol AvatarService: Sendable {
  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws
}
