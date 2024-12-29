//
//  View+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
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

}
