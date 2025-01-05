//
//  ModalSupportView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/4/25.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {

  @Binding var showModal: Bool
  @ViewBuilder var content: Content

  var body: some View {
    ZStack {
      if showModal {
        Color.black.opacity(0.6)
          .ignoresSafeArea()
          .transition(AnyTransition.opacity.animation(.smooth))
          .onTapGesture {
            showModal = false
          }
          .zIndex(1)

        content
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .ignoresSafeArea()
          .zIndex(2)
      }
    }
    .zIndex(9999)
    .animation(.bouncy, value: showModal)
  }

}

extension View {

  func showModal(_ showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
    self
      .overlay(
        ModalSupportView(showModal: showModal) {
          content()
        }
      )
  }

}

private struct PreviewView: View {

  @State private var showModal: Bool = false

  var body: some View {
    Button("Tap me") { showModal = true }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .showModal($showModal) {
        RoundedRectangle(cornerRadius: 16)
          .foregroundStyle(Color(uiColor: .systemBackground))
          .padding(40)
          .padding(.vertical, 100)
          .onTapGesture {
            showModal = false
          }
          .transition(.move(edge: .bottom))
      }
  }

}

#Preview {
  PreviewView()
}