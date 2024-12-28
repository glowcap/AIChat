//
//  AppViewBuilder.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct AppViewBuilder<TabBarView: View, OnboardingView: View>: View {

  var showTabBar: Bool = false

  @ViewBuilder var tabBarView: TabBarView
  @ViewBuilder var onboardingView: OnboardingView

  var body: some View {
    ZStack {
      if showTabBar {
        tabBarView
        .transition(.move(edge: .trailing))
      } else {
        onboardingView
        .transition(.move(edge: .leading))
      }
    }
    .animation(.smooth, value: showTabBar)
  }

}

private struct PreviewView: View {

  @State private var showTabBar: Bool = false

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
    .onTapGesture {
      showTabBar.toggle()
    }
  }
}

#Preview {
  PreviewView()
}
