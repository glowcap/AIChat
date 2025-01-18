//
//  CategoryListView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/5/25.
//

import SwiftUI

struct CategoryListView: View {

  @Environment(AvatarManager.self) var avatarManager

  @Binding var path: [NavigationPathOption]
  var category: AvatarType = .alien
  var imageName: String = Constants.randomImage

  @State private var avatars: [AvatarModel] = []
  @State private var isLoading: Bool = true
  @State private var showAlert: AnyAppAlert?

  var body: some View {
    ZStack {
      easterEggIcon
      mainContent
    }
    .showCustomAlert(alert: $showAlert)
    .task {
      await getAvatars(category: category)
    }
  }

}

// MARK: - Subviews

private extension CategoryListView {

  var easterEggIcon: some View {
    Text(category.easterEggIcon)
      .font(.largeTitle)
      .frame(maxHeight: .infinity, alignment: .top)
  }

  var mainContent: some View {
    List {
      headerCell
      if avatars.isEmpty, isLoading {
        loadingView
      } else if avatars.isEmpty {
        noAvatarsView
      } else {
        avatarListSection
      }
    }
    .ignoresSafeArea(edges: [.top])
    .listStyle(.plain)
  }

  var headerCell: some View {
    CategoryCellView(
      title: category.categoryName,
      imageName: imageName,
      font: .largeTitle,
      cornerRadius: 0
    )
    .removeListRowFormatting()
  }

  var avatarListSection: some View {
    ForEach(avatars, id: \.self) { avatar in
      CustomListCellView(
        imageName: avatar.profileImageName,
        title: avatar.name,
        subtitle: avatar.description
      )
      .anyButton(.highlight) {
        onAvatarPressed(avatar: avatar)
      }
      .removeListRowFormatting()
    }
  }

  var loadingView: some View {
    ProgressView("Gathering \(category.categoryName)...")
      .progressViewStyle(.contentLoader)
      .frame(maxWidth: .infinity)
      .padding(.top, 16)
      .removeListRowFormatting()
  }

  var noAvatarsView: some View {
    Text("No avatars found 👤")
      .font(.body)
      .foregroundStyle(.secondary)
      .frame(maxWidth: .infinity)
      .padding(16)
      .listRowSeparator(.hidden)
      .removeListRowFormatting()
  }

}

// MARK: - Private functions

private extension CategoryListView {

  func getAvatars(category: AvatarType) async {
    do {
      avatars = try await avatarManager.getAvatars(category: category)
    } catch {
      print("🚨 Failed loading \(category.categoryName) avatars: \(error.localizedDescription)")
      showAlert = AnyAppAlert(error: error)
    }
    isLoading = false
  }

  func onAvatarPressed(avatar: AvatarModel) {
    path.append(.chat(avatarId: avatar.avatarId))
  }

}

#Preview("Has Data") {
  CategoryListView(path: .constant([]))
    .environment(AvatarManager(
      remote: MockAvatarService(),
      local: MockLocalAvatarPersistence()
    ))
}

#Preview("No Data") {
  CategoryListView(path: .constant([]))
    .environment(AvatarManager(
      remote: MockAvatarService(avatars: []),
      local: MockLocalAvatarPersistence()
    ))
}

#Preview("Slow Loading") {
  CategoryListView(path: .constant([]))
    .environment(AvatarManager(
      remote: MockAvatarService(avatars: [], delay: 10.0),
      local: MockLocalAvatarPersistence()
    ))
}

#Preview("Error Loading") {
  CategoryListView(path: .constant([]))
    .environment(AvatarManager(
      remote: MockAvatarService(avatars: [], delay: 1.0, showError: true),
      local: MockLocalAvatarPersistence()
    ))
}
