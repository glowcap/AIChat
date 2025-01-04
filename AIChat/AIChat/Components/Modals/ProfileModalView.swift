//
//  ProfileModalView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/4/25.
//

import SwiftUI

struct ProfileModalView: View {

  var imageName: String? = Constants.randomImage
  var title: String? = "Alpha"
  var subtitle: String? = "Alien"
  var headline: String? = "An alien in the park."
  var onXMarkPressed: () -> Void = { }

  var body: some View {
      VStack(spacing: 0) {
        if let imageName {
          ImageLoaderView(
            urlString: imageName,
            forceTransitionAnimation: true
          )
            .aspectRatio(1, contentMode: .fit)
        }
        textContent
      }
      .background(.thickMaterial)
      .cornerRadius(16)
      .overlay(alignment: .topTrailing) {
        xMarkButton
      }
  }

}

// MARK: - Subviews

private extension ProfileModalView {

  var textContent: some View {
    VStack(alignment: .leading, spacing: 4) {
      if let title {
        Text(title)
          .font(.title)
          .fontWeight(.semibold)
      }
      if let subtitle {
        Text(subtitle)
          .font(.title3)
          .foregroundStyle(.secondary)
      }
      if let headline {
        Text(headline)
          .font(.subheadline)
      }
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  var xMarkButton: some View {
    Image(systemName: "xmark.circle.fill")
      .font(.title)
      .foregroundStyle(.black)
      .padding(4)
      .tappableBackground()
      .anyButton(action: onXMarkPressed)
      .padding(8)
  }

}

#Preview("with Image") {

  ZStack {
    List(0..<10, id: \.self) {
      Text("\($0)")
    }.listStyle(.plain)
    Color.black.opacity(0.6)
      .ignoresSafeArea()

    ProfileModalView()
      .padding(40)
  }

}

#Preview("without Image") {

  ZStack {
    List(0..<10, id: \.self) {
      Text("\($0)")
    }.listStyle(.plain)
    Color.black.opacity(0.6)
      .ignoresSafeArea()

    ProfileModalView(imageName: nil)
      .padding(40)
  }

}
