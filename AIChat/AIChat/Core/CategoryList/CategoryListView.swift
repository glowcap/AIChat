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
      if avatars.isEmpty && isLoading {
        loadingView
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
    LoaderView("Gathering \(category.categoryName)...")
      .removeListRowFormatting()
      .frame(maxWidth: .infinity)
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

#Preview {
  CategoryListView(path: .constant([]))
    .environment(AvatarManager(service: MockAvatarService()))
}
