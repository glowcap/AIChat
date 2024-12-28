//
//  SettingsView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct SettingsView: View {

  @Environment(\.dismiss) private var dismiss
  @Environment(AppState.self) private var root

  var body: some View {
    NavigationStack {
      List {
        Button {
          onSignOutPressed()
        } label: {
          Text("Sign Out")
        }
      }
      .navigationTitle("Settings")
    }
  }
}

private extension SettingsView {

  func onSignOutPressed() {
    // do some logic to sign user out of app
    dismiss()
    Task {
      try? await Task.sleep(for: .seconds(0.3))
      root.updateViewState(showTabBarView: false)
    }
  }

}

#Preview {
  SettingsView()
}
