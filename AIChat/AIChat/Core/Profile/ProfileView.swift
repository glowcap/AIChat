//
//  ProfileView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ProfileView: View {

  @State private var showSettingsView: Bool = false

  var body: some View {
    NavigationStack {
      Text("Profile")
        .navigationTitle("Profile")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            settingsButton
          }
        }
        .sheet(isPresented: $showSettingsView) {
          Text("Settings View")
        }
    }
  }

}

// MARK: - Subviews

private extension ProfileView {

  var settingsButton: some View {
    Button {
      showSettingsView = true
    } label: {
      Image(systemName: "gear")
        .font(.headline)
    }
  }

}

// MARK: - Private Functions
private extension ProfileView {

  func settingsButtonPressed() {
    showSettingsView = true
  }

}

#Preview {
  ProfileView()
}
