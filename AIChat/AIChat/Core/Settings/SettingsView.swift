//
//  SettingsView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct SettingsView: View {
  @Environment(AuthManager.self) private var authManager
  @Environment(UserManager.self) private var userManager
  @Environment(\.dismiss) private var dismiss
  @Environment(AppState.self) private var root

  @State private var isPremium: Bool = false
  @State private var isAnonymousUser: Bool = false
  @State private var showCreateAccountView: Bool = false
  @State private var showAlert: AnyAppAlert?

  var body: some View {
    NavigationStack {
      List {
        accountSection
        if !isAnonymousUser {
          purchasesSection
        }
        appSection
      }
      .navigationTitle("Settings")
      .sheet(
        isPresented: $showCreateAccountView,
        onDismiss: setAnonymousAccountStatus
      ) {
        CreateAccountView()
          .presentationDetents([.medium])
      }
      .showCustomAlert(alert: $showAlert)
      .onAppear(perform: setAnonymousAccountStatus)
    }
  }

}

// MARK: - Subveiws

private extension SettingsView {

  var accountSection: some View {
    Section {
      if isAnonymousUser {
        Text("Save & back-up account")
          .rowFormatting()
          .anyButton(.highlight, action: onCreateAccountPressed)
          .removeListRowFormatting()
      } else {
        Text("Sign Out")
          .rowFormatting()
          .anyButton(.highlight, action: onSignOutPressed)
          .removeListRowFormatting()

        Text("Delete Account")
          .rowFormatting(isDestructive: true)
          .anyButton(.highlight, action: onDeleteAccountPressed)
          .removeListRowFormatting()
      }
    } header: {
      Text("Account")
    }
  }

  var purchasesSection: some View {
    Section {
      HStack(spacing: 8) {
        Text("Account Status: \(isPremium ? "Premium" : "Basic")")
        Spacer()
        Text("\(isPremium ? "MANAGE" : "UPGRADE")")
          .badgeButton()
      }
      .rowFormatting()
      .anyButton(.highlight, action: onAccountStatusPressed)
      .removeListRowFormatting()
    } header: {
      Text("Purchases")
    }
  }

  var appSection: some View {
    Section {
      HStack(spacing: 8) {
        Text("Version")
        Spacer()
        Text(Bundle.main.appVersion)
          .foregroundStyle(.secondary)
      }
      .rowFormatting()
      .removeListRowFormatting()

      HStack(spacing: 8) {
        Text("Build Number")
        Spacer()
        Text(Bundle.main.buildVersion)
          .foregroundStyle(.secondary)
      }
      .rowFormatting()
      .removeListRowFormatting()

      Text("Contact us")
        .foregroundStyle(.blue)
        .rowFormatting()
        .anyButton(.highlight, action: onContactPressed)
        .removeListRowFormatting()

    } header: {
      Text("Application")
    } footer: {
      Text("Powered By Unicorns and Rainbows 🌈🦄\nBuilt by www.daymein.info")
        .baselineOffset(6)
    }
  }

}

// MARK: - Private functions

private extension SettingsView {

  func onSignOutPressed() {
    tryAndDismiss(signOut)
  }

  func signOut() throws {
    try authManager.signOut()
    userManager.signOut()
  }

  func onDeleteAccountPressed() {
    showAlert = AnyAppAlert(
      title: "Delete Account?",
      subtitle: "This action is permanent and cannot be undone. Your data will be removed from our servers",
      buttons: {
        AnyView(
          Group {
            Button("Delete", role: .destructive) { onDeleteAccountConfirmed() }
          }
        )
      }
    )
  }

  func onDeleteAccountConfirmed() {
    tryAndDismiss(deleteAccount)
  }

  func deleteAccount() async throws {
    try await authManager.deleteAccount()
    try await userManager.deleteCurrentUser()
  }

  func tryAndDismiss(_ action: @escaping () async throws -> Void) {
    Task {
      do {
        try await action()
        dismissScreen()
      } catch {
        showAlert = AnyAppAlert(error: error)
      }
    }
  }

  func onCreateAccountPressed() {
    showCreateAccountView = true
  }

  func onAccountStatusPressed() {
    // do some logic to update or check account status
  }

  func onContactPressed() {
    // do some logic to contact us
  }

  func setAnonymousAccountStatus() {
    isAnonymousUser = authManager.auth?.isAnonymous == true
  }

  func dismissScreen() {
    dismiss()
    root.updateViewState(showTabBarView: false)
  }

}

// MARK: - Local View extensions

fileprivate extension View {

  func rowFormatting(isDestructive: Bool = false) -> some View {
    self
      .foregroundStyle(isDestructive ? .red : .primary)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 12)
      .padding(.horizontal, 16)
      .background(Color(uiColor: .systemBackground))
  }

}

#Preview("Anonymous") {
  SettingsView()
    .environment(AuthManager(
      service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: true))
    ))
    .environment(UserManager(services: MockUserServices(user: .mock)))
    .environment(AppState())
}

#Preview("Signed In") {
  SettingsView()
    .environment(AuthManager(
      service: MockAuthService(user: UserAuthInfo.mock())
    ))
    .environment(UserManager(services: MockUserServices(user: .mock)))
    .environment(AppState())
}

#Preview("No Auth") {
  SettingsView()
    .environment(AuthManager(service: MockAuthService()))
    .environment(UserManager(services: MockUserServices()))
    .environment(AppState())
}
