//
//  ProfileView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ProfileView: View {

  @Environment(AuthManager.self) private var authManager
  @Environment(UserManager.self) private var userManager
  @Environment(AvatarManager.self) private var avatarManager

  @State private var showSettingsView: Bool = false
  @State private var showCreateAvatarView: Bool = false
  @State private var currentUser: UserModel?
  @State private var currentUserAvatars: [AvatarModel] = []
  @State private var isLoading: Bool = true

  @State private var path: [NavigationPathOption] = []

  var body: some View {
    NavigationStack(path: $path) {
      List {
        userInfoSection
        userAvatarSection
      }
      .navigationTitle("Profile")
      .coreModuleNavigationDestination(path: $path)
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
        onDismiss: { Task { await loadData() }},
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
      if currentUserAvatars.isEmpty, isLoading {
        loadingView
      } else if currentUserAvatars.isEmpty {
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
      .anyButton(.highlight, action: { onAvatarPressed(avatar: avatar) })
      .removeListRowFormatting()
    }
    .onDelete(perform: onDeleteAvatar)
  }

  var loadingView: some View {
    ProgressView("Finding your avatars...")
      .progressViewStyle(.contentLoader)
      .removeListRowFormatting()
      .frame(maxWidth: .infinity)
  }

}

// MARK: - Private Functions
private extension ProfileView {

  func loadData() async {
    currentUser = userManager.currentUser
    do {
      let uid = try authManager.getAuthId()
      currentUserAvatars = try await avatarManager.getAvatarsForAuthor(userId: uid)
    } catch {
      print("🚨 Failed loading avatars: \(error.localizedDescription)")
    }
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

  func onAvatarPressed(avatar: AvatarModel) {
    path.append(.chat(avatarId: avatar.avatarId))
  }

}

#Preview {
  ProfileView()
    .previewEnvironment()
}
