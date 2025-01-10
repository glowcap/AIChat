//
//  AppView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct AppView: View {
  @Environment(AuthManager.self) private var authManager
  @State var appState: AppState = AppState()

  var body: some View {
    AppViewBuilder(
      showTabBar: appState.showTabBar,
      tabBarView: {
        TabBarView()
      },
      onboardingView: {
        WelcomeView()
      }
    )
    .environment(appState)
    .task {
      await checkUserStatus()
    }
    .onChange(of: appState.showTabBar) { _, showTabBar in
      guard !showTabBar else { return }
      Task { await checkUserStatus() }
    }
  }

}

// MARK: - Private functions

private extension AppView {

  private func checkUserStatus() async {
    if let user = authManager.auth {
      print("✅ User already authenticated: \(user.uid)")
    } else {
      do {
        let result = try await authManager.signInAnonymously()
        print("🎉 Anonymous sign in successful: \(result.user.uid)")
      } catch {
        print(error.localizedDescription)
      }
    }
  }

}

#Preview("TabBar") {
  AppView(appState: AppState(showTabBar: true))
}

#Preview("Onboarding") {
  AppView(appState: AppState(showTabBar: false))
}
