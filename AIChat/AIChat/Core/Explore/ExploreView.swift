//
//  ExploreView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ExploreView: View {

  @Environment(AvatarManager.self) var avatarManager

  @State private var featuredAvatars: [AvatarModel] = []
  @State private var categories: [AvatarType] = AvatarType.allCases
  @State private var popularAvatars: [AvatarModel] = []

  @State private var path: [NavigationPathOption] = []

  var body: some View {
    NavigationStack(path: $path) {
      List {
        if featuredAvatars.isEmpty, popularAvatars.isEmpty {
          loadingView
        }
        if !featuredAvatars.isEmpty {
          featuredSection
        }
        if !popularAvatars.isEmpty {
          categorySection
          popularSection
        }
      }
      .listStyle(.plain)
      .navigationTitle("Explore")
      .coreModuleNavigationDestination(path: $path)
      .task {
        await loadFeaturedAvatars()
      }
      .task {
        await loadPopularAvatars()
      }
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

  var loadingView: some View {
    LoaderView("Gathering avatars...")
    .removeListRowFormatting()
    .frame(maxWidth: .infinity)
  }

}

// MARK: - Private functions

private extension ExploreView {

  func loadFeaturedAvatars() async {
    guard featuredAvatars.isEmpty else { return }
    do {
      featuredAvatars = try await avatarManager.getFeaturedAvatars()
    } catch {
      print("🚨 Failed loading featured avatars: \(error.localizedDescription)")
    }
  }

  func loadPopularAvatars() async {
    guard popularAvatars.isEmpty else { return }
    do {
      popularAvatars = try await avatarManager.getPopularAvatars()
    } catch {
      print("🚨 Failed loading popular avatars: \(error.localizedDescription)")
    }
  }

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
    .environment(AvatarManager(service: MockAvatarService()))
}
