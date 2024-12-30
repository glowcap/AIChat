//
//  ViewModifiers.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import SwiftUI

extension View {

  func ctaButton() -> some View {
    self
      .font(.headline)
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity)
      .frame(height: 55)
      .background(.accent)
      .cornerRadius(16)
  }

  func tappableBackground() -> some View {
    background(Color.black.opacity(0.001))
  }

  func removeListRowFormatting() -> some View {
    self
      .listRowSeparator(.hidden)
      .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      .listRowBackground(Color.clear)
  }

  func textBackgroundGradient() -> some View {
    background(
        LinearGradient(
          colors: [
            Color.black.opacity(0),
            Color.black.opacity(0.3),
            Color.black.opacity(0.6)
          ],
          startPoint: .top,
          endPoint: .bottom
        )
      )
  }

}