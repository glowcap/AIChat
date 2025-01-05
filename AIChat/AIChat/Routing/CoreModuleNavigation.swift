//
//  CoreModuleNavigation.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/5/25.
//

import SwiftUI

enum NavigationPathOption: Hashable {
  case category(category: AvatarType, imageName: String)
  case chat(avatarId: String)
}

extension View {

  @ViewBuilder
  func coreModuleNavigationDestination(path: Binding<[NavigationPathOption]>) -> some View {
    self
      .navigationDestination(for: NavigationPathOption.self) { newValue in
        switch newValue {
        case let .category(category, imageName):
          CategoryListView(path: path, category: category, imageName: imageName)
        case let .chat(avatarId):
          ChatView(avatarId: avatarId)
        }
      }
  }

}
