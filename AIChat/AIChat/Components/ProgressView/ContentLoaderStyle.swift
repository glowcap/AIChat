//
//  ContentLoaderStyle.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/18/25.
//

import SwiftUI

struct ContentLoaderStyle: ProgressViewStyle {
  func makeBody(configuration: Configuration) -> some View {
    VStack(spacing: 12) {
      ProgressView()
        .progressViewStyle(.circular)
        .controlSize(.large)
        .tint(.accent)
      configuration.label
    }
    .font(.body)
    .fontWeight(.semibold)
    .foregroundStyle(.accent)
  }
}

extension ProgressViewStyle where Self == ContentLoaderStyle {
  static var contentLoader: ContentLoaderStyle { .init() }
}

private struct PreviewBuilder: View {

  var message: String

  init(_ message: String) {
    self.message = message
  }

  var body: some View {
    ProgressView(message)
      .progressViewStyle(.contentLoader)
  }
}

#Preview {
  PreviewBuilder("loading data...")
}
