//
//  AppView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct AppView: View {
  @Environment(AuthManager.self) private var authManager
  @Environment(UserManager.self) private var userManager
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
      do {
        try userManager.logIn(auth: AuthInfo(user: user, isNewUser: false))
        print("🛎️ Did log in")
      } catch {
        print("⛔️ Log in existing user failed: \(error.localizedDescription)")
        try? await Task.sleep(for: .seconds(3))
        await checkUserStatus()
      }
    } else {
      do {
        let result = try await authManager.signInAnonymously()
        print("🎉 Anonymous sign in successful: \(result.user.uid)")
        try userManager.logIn(auth: result)
        print("🛎️ Did log in")
      } catch {
        print("⛔️ Sign in and log in anonymous user failed: \(error.localizedDescription)")
        try? await Task.sleep(for: .seconds(3))
        await checkUserStatus()
      }
    }
  }

}

#Preview("TabBar") {
  AppView(appState: AppState(showTabBar: true))
    .environment(AuthManager(service: MockAuthService(user: .mock())))
    .environment(UserManager(service: MockUserService(user: .mock)))
}

#Preview("Onboarding") {
  AppView(appState: AppState(showTabBar: false))
    .environment(AuthManager(service: MockAuthService(user: nil)))
    .environment(UserManager(service: MockUserService(user: nil)))
}
