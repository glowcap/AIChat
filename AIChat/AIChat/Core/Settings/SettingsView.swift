//
//  SettingsView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct SettingsView: View {

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
    root.updateViewState(showTabBarView: false)
  }

}

#Preview {
  SettingsView()
}
