//
//  OnboardingIntroView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import SwiftUI

struct OnboardingIntroView: View {
  var body: some View {
    VStack {
      textContent
      .padding(24)

      ctaButton
    }
    .font(.title3)
    .padding(24)
    .toolbar(.hidden, for: .navigationBar)
  }
}

// MARK: - Subviews

private extension OnboardingIntroView {

  var textContent: some View {
    Group {
      Text("Make your own ")
      +
      Text("avatars")
        .foregroundStyle(.accent)
        .fontWeight(.semibold)
      +
      Text(" and chat with them!\n\nHave ")
      +
      Text("real conversations")
        .foregroundStyle(.accent)
        .fontWeight(.semibold)
      +
      Text(" with AI generated responses.")
    }
    .baselineOffset(6)
    .frame(maxHeight: .infinity)
  }

  var ctaButton: some View {
    NavigationLink {
      OnboardingColorView()
    } label: {
      Text("Continue")
        .ctaButton()
    }
  }
}

#Preview {
  NavigationStack {
    OnboardingIntroView()
  }
  .environment(AppState())
}
