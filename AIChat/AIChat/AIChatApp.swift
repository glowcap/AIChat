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
        .environment(delegate.authManager)
        .environment(delegate.userManager)
    }
  }

}

class AppDelegate: NSObject, UIApplicationDelegate {

  var authManager: AuthManager!
  var userManager: UserManager!

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
    authManager = AuthManager(service: FirebaseAuthService())
    userManager = UserManager(services: ProductionUserServices())

    return true
  }

}
