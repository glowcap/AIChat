//
//  ProfileView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ProfileView: View {

  @State private var showSettingsView: Bool = false
  @State private var showCreateAvatarView: Bool = false
  @State private var currentUser: UserModel? = .mock
  @State private var currentUserAvatars: [AvatarModel] = []
  @State private var isLoading: Bool = true

  var body: some View {
    NavigationStack {
      List {
        userInfoSection
        userAvatarSection
      }
      .navigationTitle("Profile")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          settingsButton
        }
      }
      .sheet(
        isPresented: $showSettingsView,
        content: { SettingsView() }
      )
      .fullScreenCover(
        isPresented: $showCreateAvatarView,
        content: { CreateAvatarView() }
      )
      .task {
        await loadData()
      }
    }
  }

}

// MARK: - Subviews

private extension ProfileView {

  var settingsButton: some View {
    Image(systemName: "gear")
      .font(.headline)
      .foregroundStyle(.accent)
      .anyButton {
        showSettingsView = true
      }
  }

  var userInfoSection: some View {
    Section {
      Circle()
        .fill(currentUser?.profileColor ?? .accent)
        .frame(width: 100, height: 100)
        .frame(maxWidth: .infinity)
        .removeListRowFormatting()
    }

  }

  var userAvatarSection: some View {
    Section {
      if currentUserAvatars.isEmpty {
        emptyAvatarsView
      } else {
        populatedAvatarsView
      }
    } header: {
      HStack(spacing: 0) {
        Text("My Avatars")
        Spacer()
        Image(systemName: "plus.circle.fill")
          .font(.title)
          .foregroundStyle(.accent)
          .anyButton(action: addAvatarButtonPressed)
      }
    }
  }

  var emptyAvatarsView: some View {
    Group {
      if isLoading {
        ProgressView()
      } else {
        Text("Click + to create an avatar")
      }
    }
    .font(.body)
    .foregroundStyle(.secondary)
    .padding(64)
    .frame(maxWidth: .infinity)
    .removeListRowFormatting()
  }

  var populatedAvatarsView: some View {
    ForEach(currentUserAvatars, id: \.self) { avatar in
      CustomListCellView(
        imageName: avatar.profileImageName,
        title: avatar.name,
        subtitle: nil
      )
      .anyButton(.highlight, action: {})
      .removeListRowFormatting()
    }
    .onDelete(perform: onDeleteAvatar)
  }

}

// MARK: - Private Functions
private extension ProfileView {

  func loadData() async {
    try? await Task.sleep(for: .seconds(1))
    currentUserAvatars = AvatarModel.mocks
    isLoading = false
  }

  func settingsButtonPressed() {
    showSettingsView = true
  }

  func addAvatarButtonPressed() {
    showCreateAvatarView = true
  }

  func onDeleteAvatar(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    currentUserAvatars.remove(at: index)
  }

}

#Preview {
  ProfileView()
    .environment(AppState())
}
