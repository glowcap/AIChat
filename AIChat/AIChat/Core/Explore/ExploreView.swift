//
//  ExploreView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ExploreView: View {

  @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
  @State private var categories: [AvatarType] = AvatarType.allCases
  @State private var popularAvatars: [AvatarModel] = AvatarModel.mocks

  @State private var path: [NavigationPathOption] = []

  var body: some View {
    NavigationStack(path: $path) {
      List {
        featuredSection
        categorySection
        popularSection
      }
      .listStyle(.plain)
      .navigationTitle("Explore")
      .coreModuleNavigationDestination(path: $path)
    }
  }

}

// MARK: - Subviews

private extension ExploreView {

  var featuredSection: some View {
    Section {
      // Nesting CarouselView in ZStack fixes swipe glitch
      ZStack {
        CarouselView(items: featuredAvatars) { avatar in
          HeroCellView(
            title: avatar.name,
            subtitle: avatar.description,
            imageName: avatar.profileImageName
          )
          .anyButton {
            onAvatarPressed(avatar: avatar)
          }
          .padding(.horizontal, 16)
        }
      }
      .removeListRowFormatting()
    } header: {
      ZStack {
        Text("Featured Avatars")
      }
    }
  }

  var categorySection: some View {
    Section {
      // Nesting ScrollView in ZStack fixes swipe glitch
      ZStack {
        ScrollView(.horizontal) {
          HStack(spacing: 12) {
            ForEach(categories, id: \.self) { category in
              if let imageName = getCategoryImageName(category) {
                CategoryCellView(title: category.categoryName, imageName: imageName)
                  .anyButton {
                    onCategoryPressed(category: category, imageName: imageName)
                  }
              }
            }
          }
        }
        .frame(height: 140)
        .scrollIndicators(.hidden)
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
      }
      .removeListRowFormatting()
    } header: {
      Text("Categories")
    }
  }

  var popularSection: some View {
    Section {
      ForEach(popularAvatars, id: \.self) { avatar in
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
    } header: {
      Text("Popular")
    }
  }

}

// MARK: - Private functions

private extension ExploreView {

  func onAvatarPressed(avatar: AvatarModel) {
    path.append(.chat(avatarId: avatar.avatarId))
  }

  func onCategoryPressed(category: AvatarType, imageName: String) {
    path.append(.category(category: category, imageName: imageName))
  }

  func getCategoryImageName(_ category: AvatarType ) -> String? {
    popularAvatars
      .first(where: { $0.avatarType == category })?
      .profileImageName
  }

}

#Preview {
  ExploreView()
}
