//
//  CarouselView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import SwiftUI

struct CarouselView<Content: View, T: Hashable>: View {

  var items: [T]
  @ViewBuilder var content: (T) -> Content

  @State private var selection: T?

  var body: some View {
    VStack(spacing: 12) {
      contentScrollView
        .onChange(of: items.count) {
          updateSelectionIfNeeded()
        }
        .onAppear {
          updateSelectionIfNeeded()
        }

      paginationView
    }
  }

}

// MARK: - Subviews

private extension CarouselView {

  var contentScrollView: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 0) {
        ForEach(items, id: \.self) { item in
          content(item)
            .scrollTransition(
              .interactive.threshold(.visible(0.95)),
              transition: { content, phase in
                content
                  .scaleEffect(phase.isIdentity ? 1 : 0.9)
              }
            )
            .containerRelativeFrame(.horizontal, alignment: .center)
            .id(item)
        }
      }
    }
    .frame(height: 200)
    .scrollIndicators(.hidden)
    .scrollTargetLayout()
    .scrollTargetBehavior(.paging)
    .scrollPosition(id: $selection)
  }

  var paginationView: some View {
    HStack(spacing: 8) {
      ForEach(items, id: \.self) { item in
        Circle()
          .fill(item == selection ? .accent : .secondary.opacity(0.5))
          .frame(width: 8, height: 8)
      }
    }
    .animation(.linear, value: selection)
  }

}

// MARK: - Private functions

private extension CarouselView {

  func updateSelectionIfNeeded() {
    if selection == nil || selection == items.last {
      selection = items.first
    }
  }

}

#Preview("Hero") {
  CarouselView(
    items: AvatarModel.mocks,
    content: { item in
    HeroCellView(
      title: item.name,
      subtitle: item.avatarDescription,
      imageName: item.profileImageName
    )
  })
}

// CarouselView needs support for viewAligned with non-centered items
#Preview("Standard") {
  CarouselView(
    items: AvatarType.allCases,
    content: { item in
      HeroCellView(
        title: item.rawValue,
        subtitle: nil,
        imageName: Constants.randomImage
      )
      .frame(width: 140, height: 140)
  })
}
