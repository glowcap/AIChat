//
//  ButtonViewModifiers.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import SwiftUI

enum ButtonStyleOption {
  case highlight, plain, press
}

struct HighlightButtonStyle: ButtonStyle {

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .overlay {
        configuration.isPressed
        ? Color.accent.opacity(0.4)
        : Color.accent.opacity(0)
      }
      .animation(.smooth, value: configuration.isPressed)
  }
}

struct PressableButtonStyle: ButtonStyle {

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(.smooth, value: configuration.isPressed)
  }
}

extension View {

  @ViewBuilder
  func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
    switch option {
    case .highlight:
      self.highlightButton(action: action)
    case .plain:
      self.plainButton(action: action)
    case .press:
      self.pressableButton(action: action)
    }
  }

}

private extension View {

  func plainButton(action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      self
    }
    .buttonStyle(PlainButtonStyle())
  }

  func highlightButton(action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      self
    }
    .buttonStyle(HighlightButtonStyle())
  }

  func pressableButton(action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      self
    }
    .buttonStyle(PressableButtonStyle())
  }

}

#Preview {
  VStack {
    Text("Highlight Button")
      .padding()
      .frame(maxWidth: .infinity)
      .tappableBackground()
      .anyButton(.highlight, action: { })

    Text("Pressable Button")
      .padding()
      .frame(maxWidth: .infinity)
      .ctaButton()
      .anyButton(.press, action: { })
      .padding()

    Text("Plain Button")
      .padding()
      .frame(maxWidth: .infinity)
      .ctaButton()
      .anyButton(action: { })
      .padding()

    Button {
      // action
    } label: {
      Text("Tap Me")
        .ctaButton()
    }
    .buttonStyle(.plain)
    .padding()
  }

}
