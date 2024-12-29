//
//  OnboardingColorView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import SwiftUI

struct OnboardingColorView: View {

  @State private var selectedColor: Color?

  let profileColors: [Color] = [
    .red, .green, .orange, .blue, .mint,
    .purple, .cyan, .teal, .indigo
  ]

  var body: some View {
    ScrollView {
      colorGrid
        .padding(.top, 24)
        .padding(.horizontal, 24)
    }
    .safeAreaInset(
      edge: .bottom,
      alignment: .center,
      spacing: 16,
      content: {
        ZStack {
          if let selectedColor {
            ctaButton(selectedColor: selectedColor)
              .transition(AnyTransition.move(edge: .bottom))
          }
        }
        .padding(24)
        .background(Color(uiColor: .systemBackground))
      }
    )
    .animation(.bouncy, value: selectedColor)
    .toolbar(.hidden, for: .navigationBar)
  }

}

// MARK: - Subviews

private extension OnboardingColorView {

  var colorGrid: some View {
    LazyVGrid(
      columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
      alignment: .center,
      spacing: 16,
      pinnedViews: [.sectionHeaders]
    ) {
      Section {
        ForEach(profileColors, id: \.self) { color in
          Circle()
            .fill(.accent)
            .overlay(
              color
                .clipShape(Circle())
                .padding(selectedColor == color ? 10 : 0)
            )
            .onTapGesture {
              selectedColor = color
            }
        }
      } header: {
        Text("Select a profile color")
          .font(.headline)
      }
    }
  }

  func ctaButton(selectedColor: Color) -> some View {
    NavigationLink {
      OnboardingCompletedView(selectedColor: selectedColor)
    } label: {
      Text("Continue")
        .ctaButton()
    }
  }

}

#Preview {
  NavigationStack {
    OnboardingColorView()
  }
  .environment(AppState())
}