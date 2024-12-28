//
//  AppView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct AppView: View {

  @AppStorage("showTabBarView") var showTabBar: Bool = false

  var body: some View {
    AppViewBuilder(showTabBar: showTabBar,
      tabBarView: {
        ZStack {
          Color.pink.ignoresSafeArea()
          Text("TabBar")
        }
      }, onboardingView: {
        ZStack {
          Color.purple.ignoresSafeArea()
          Text("Onboarding")
        }
      }
    )
  }
}

#Preview("TabBar") {
  AppView(showTabBar: true)
}

#Preview("Onboarding") {
  AppView(showTabBar: false)
}
