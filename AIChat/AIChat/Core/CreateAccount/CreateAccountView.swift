//
//  CreateAccountView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct CreateAccountView: View {

  @Environment(\.authService) var authService
  @Environment(\.dismiss) var dismiss

  var title: String = "Create Account?"
  var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account info."
  var onDidSignIn: ((_ isNewUser: Bool) -> Void)?

  var body: some View {
    VStack(spacing: 24) {
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.largeTitle)
        Text(subtitle)
          .font(.body)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      Spacer()

      SignInWithAppleButtonView(
        type: .signIn,
        style: .black,
        cornerRadius: 10
      )
      .frame(height: 55)
      .anyButton(.press, action: onSignInApplePressed)
    }
    .padding(.horizontal, 16)
    .padding(.top, 40)
  }
}

private extension CreateAccountView {

  func onSignInApplePressed() {
    Task {
      do {
        let result = try await authService.signInApple()
        print("🍏 Signed in with Apple")
        onDidSignIn?(result.isNewUser)
        dismiss()
      } catch {
        print("⛔️ Error signing in with Apple: \(error.localizedDescription)")
      }
    }
  }

}

#Preview {
  CreateAccountView()
}
