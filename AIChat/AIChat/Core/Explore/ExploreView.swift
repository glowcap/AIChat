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

  var body: some View {
    NavigationStack {
      List {
        featuredSection
        categorySection
      }
      .listStyle(.plain)
      .navigationTitle("Explore")
    }
  }
}

// MARK: - Subviews

private extension ExploreView {

  var featuredSection: some View {
    Section {
      // Nesting CarouselView in ZStck fixes swipe glitch
      ZStack {
        CarouselView(items: featuredAvatars) { avatar in
          HeroCellView(
            title: avatar.name,
            subtitle: avatar.avatarDescription,
            imageName: avatar.profileImageName
          )
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
      ZStack {
        ScrollView(.horizontal) {
          HStack(spacing: 12) {
            ForEach(categories, id: \.self) { category in
              CategoryCellView(
                title: category.categoryName,
                imageName: Constants.randomImage
              )
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

}

#Preview {
  ExploreView()
}
