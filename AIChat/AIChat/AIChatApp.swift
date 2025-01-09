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
      EnvironmentBuilderView {
        AppView()
      }
    }
  }
  
}

struct EnvironmentBuilderView<Content: View>: View {

  @ViewBuilder var content: () -> Content

  var body: some View {
    content()
      .environment(\.authService, FirebaseAuthService())
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    return true
  }

}
