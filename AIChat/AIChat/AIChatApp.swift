//
//  AIChatApp.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI
import Firebase

@main
struct AIChatApp: App {

  /// For Firebase config
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      AppView()
        .environment(delegate.dependencies.aiManager)
        .environment(delegate.dependencies.avatarManager)
        .environment(delegate.dependencies.userManager)
        .environment(delegate.dependencies.authManager)
    }
  }

}

class AppDelegate: NSObject, UIApplicationDelegate {

  var dependencies: Dependencies!

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()

//    These initialize twice in @Observable inits. Although only the first
//    one is being used, it can lead to wasted time debugging. So, they're
//    being initialized here and force unwrapped since they will (and must)
//    be there on app launch. Learn more from these links:
//    Observable is not a drop-in replacement for ObservableObject:
//    https://www.jessesquires.com/blog/2024/09/09/swift-observable-macro/
//    StackOverflow Observable being re-init:
//    https://stackoverflow.com/questions/77311315/observable-is-being-re-init-every-time-view-is-modified-in-swiftui
    dependencies = Dependencies()

    return true
  }

}

@MainActor
struct Dependencies {
  let aiManager: AIManager
  let authManager: AuthManager
  let avatarManager: AvatarManager
  let userManager: UserManager

  init() {
    aiManager = AIManager(service: OpenAIService())
    authManager = AuthManager(service: FirebaseAuthService())
    avatarManager = AvatarManager(
      remote: FirebaseAvatarService(),
      local: SwiftDatLocalAvatarPersistence()
    )
    userManager = UserManager(services: ProductionUserServices())
  }
}
