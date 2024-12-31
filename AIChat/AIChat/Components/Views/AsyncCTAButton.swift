//
//  AsyncCTAButton.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct AsyncCTAButton: View {

  var title: String = ""
  var inProgress: Bool = false
  var action: () -> Void

  var body: some View {
    ZStack {
      if inProgress {
        ProgressView()
          .tint(.white)
      } else {
        Text(title)
      }
    }
    .ctaButton()
    .anyButton(.press, action: action)
    .disabled(inProgress)
  }

}

private struct PreviewView: View {
  
  @State private var isLoading: Bool = false
  
  var body: some View {
    AsyncCTAButton(
      title: "Start Working",
      inProgress: isLoading) {
        isLoading = true
        Task {
          try? await Task.sleep(for: .seconds(2))
          isLoading = false
        }
      }
  }
  
}

#Preview {
  PreviewView()
    .padding(16)

}
