//
//  View+PreviewEnvironment.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/18/25.
//

import SwiftUI

extension View {

  func previewEnvironment(isSignedIn: Bool = true) -> some View {
    self
      .environment(AIManager(service: MockAIService()))
      .environment(AvatarManager(
        remote: MockAvatarService(),
        local: MockLocalAvatarPersistence()
      ))
      .environment(UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil)))
      .environment(AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil)))
      .environment(AppState())
  }

}
