//
//  OnboardingCompletedView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct OnboardingCompletedView: View {

  @Environment(AppState.self) private var root

  var body: some View {
    VStack {
      Text("Onboaring Completed!")
        .frame(maxHeight: .infinity)
      Button {
        onFinishButtonPressed()
      } label: {
        Text("Finish")
          .ctaButton()
      }
    }
    .padding(16)
  }
}

// MARK: - Private functions

private extension OnboardingCompletedView {

  func onFinishButtonPressed() {
    // other logic to complete onboarding
    root.updateViewState(showTabBarView: true)
  }

}

#Preview {
  OnboardingCompletedView()
    .environment(AppState())
}
