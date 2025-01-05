//
//  CategoryListView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/5/25.
//

import SwiftUI

struct CategoryListView: View {

  @Binding var path: [NavigationPathOption]
  var category: AvatarType = .alien
  var imageName: String = Constants.randomImage

  @State private var avatars: [AvatarModel] = AvatarModel.mocks

  var body: some View {
    ZStack {
      easterEggIcon
      mainContent
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
      avatarListSection
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

}

// MARK: - Private functions

private extension CategoryListView {

  func onAvatarPressed(avatar: AvatarModel) {
    path.append(.chat(avatarId: avatar.avatarId))
  }

}

#Preview {
  CategoryListView(path: .constant([]))
}
