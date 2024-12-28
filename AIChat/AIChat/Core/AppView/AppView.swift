//
//  AppView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct AppView: View {

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
  }
}

#Preview("TabBar") {
  AppView(appState: AppState(showTabBar: true))
}

#Preview("Onboarding") {
  AppView(appState: AppState(showTabBar: false))
}
