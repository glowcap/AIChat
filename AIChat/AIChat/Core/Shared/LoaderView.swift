//
//  LoaderView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/16/25.
//

import SwiftUI

struct LoaderView: View {

  var message: String

  init(_ message: String) {
    self.message = message
  }

  var body: some View {
    VStack(spacing: 12) {
      ProgressView()
        .controlSize(.large)
        .tint(.accent)
        .padding(.top, 40)
      Text(message)
        .font(.body)
        .fontWeight(.semibold)
        .foregroundStyle(.accent)
    }
  }
}

#Preview {
  LoaderView("loading data...")
}
