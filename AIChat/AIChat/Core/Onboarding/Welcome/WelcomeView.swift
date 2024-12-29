//
//  WelcomeView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct WelcomeView: View {

  @State var imageName: String = Constants.randomImage

  var body: some View {
    NavigationStack {
      VStack(spacing: 8) {
        ImageLoaderView(urlString: imageName)
          .ignoresSafeArea()

        titleSection
          .padding(.top, 24)

        ctaButtons
          .padding(16)

        policyLinks
      }
    }
  }

}

// MARK: - Subviews

private extension WelcomeView {

  var titleSection: some View {
    VStack(spacing: 8) {
      Text("AI Chat 💬")
        .font(.largeTitle)
        .fontWeight(.semibold)

      Text("for the introvert in all of us")
        .font(.caption)
        .foregroundStyle(.secondary)
    }
  }

  var ctaButtons: some View {
    VStack(spacing: 8) {
      NavigationLink {
        OnboardingIntroView()
      } label: {
        Text("Get Started")
          .ctaButton()
      }

      Text("Already have an account? Sign in.")
        .underline()
        .font(.body)
        .padding(8)
        .tappableBackground()
        .onTapGesture {

        }
    }
  }

  var policyLinks: some View {
    HStack(spacing: 8) {
      Link(destination: URL(string: Constants.termsOfServiceUrl)!) {
        Text("Terms of Service")
      }

      Circle()
        .fill(.accent)
        .frame(width: 4, height: 4)

      Link(destination: URL(string: Constants.privacyPolicyUrl)!) {
        Text("Privacy Policy")
      }
    }
  }

}

#Preview {
  WelcomeView()
}
