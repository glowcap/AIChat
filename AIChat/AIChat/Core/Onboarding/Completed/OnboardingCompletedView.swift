//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct OnboardingCompletedView: View {

  @Environment(AppState.self) private var root
  @Environment(UserManager.self) private var userManager

  @State private var isCompletingProfileSetup: Bool = false

  var selectedColor: Color = .mint

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Setup Completed!")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundStyle(selectedColor)

      Text("We've set up your profile and you're ready to start chatting.")
        .font(.title)
        .fontWeight(.medium)
        .foregroundStyle(.secondary)
    }
    .frame(maxHeight: .infinity)
    .safeAreaInset(edge: .bottom) {
      ctaButton
    }
    .padding(24)
    .toolbar(.hidden, for: .navigationBar)
  }
}

// MARK: - Subviews

private extension OnboardingCompletedView {

  var ctaButton: some View {
    AsyncCTAButton(
      title: "Finish",
      inProgress: isCompletingProfileSetup,
      action: onFinishButtonPressed
    )
  }
}

// MARK: - Private functions

private extension OnboardingCompletedView {

  func onFinishButtonPressed() {
    isCompletingProfileSetup = true
    Task {
      try await userManager.markOnboardingCompleteForCurrentUser(
        profileColorHex: selectedColor.asHex()
      )
      // dismiss
      isCompletingProfileSetup = false
      root.updateViewState(showTabBarView: true)
    }
  }

}

#Preview {
  OnboardingCompletedView(selectedColor: .purple)
    .environment(UserManager(service: MockUserService()))
    .environment(AppState())
}
