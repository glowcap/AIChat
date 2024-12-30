//
//  HeroCellView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import SwiftUI

struct HeroCellView: View {

  var title: String? = "This is some title"
  var subtitle: String? = "This is some subtitle that will go here"
  var imageName: String? = Constants.randomImage

  var body: some View {
    cellBackground
      .cornerRadius(16)
  }

}

// MARK: - Subviews

private extension HeroCellView {

  var cellBackground: some View {
    ZStack {
      if let imageName {
        ImageLoaderView(urlString: imageName)
      } else {
        Rectangle()
          .fill(.accent)
      }
    }
    .overlay(
      alignment: .bottomLeading,
      content: { textContent }
    )
  }

  var textContent: some View {
    VStack(alignment: .leading, spacing: 4) {
      if let title {
        Text(title)
          .font(.headline)
      }
      if let subtitle {
        Text(subtitle)
          .font(.subheadline)
      }
    }
    .foregroundStyle(.white)
    .padding(16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .textBackgroundGradient()
  }

}

#Preview("Content Options") {
  ScrollView {
    VStack { // pushes scroll bar to screen edge
      HeroCellView()
        .frame(width: 300, height: 200)

      HeroCellView(imageName: nil)
        .frame(width: 300, height: 200)

      HeroCellView(title: nil)
        .frame(width: 300, height: 200)

      HeroCellView(subtitle: nil)
        .frame(width: 300, height: 200)
    }
    .frame(maxWidth: .infinity)
  }
}

#Preview("Size Variations") {
  ScrollView {
    VStack {
      HeroCellView()
        .frame(width: 300, height: 200)

      HeroCellView()
        .frame(width: 300, height: 400)

      HeroCellView()
        .frame(width: 200, height: 200)

      HeroCellView()
        .frame(width: 200, height: 400)
    }
    .frame(maxWidth: .infinity)
  }
}
