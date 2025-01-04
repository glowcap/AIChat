//
//  AnyAppAlert.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import SwiftUI

enum AlertType {
  case alert, confirmationDialog
}

struct AnyAppAlert: Sendable {
  var title: String
  var subtitle: String
  var buttons: @Sendable () -> AnyView

  init(
    title: String,
    subtitle: String,
    buttons: (@Sendable () -> AnyView)? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
    self.buttons = buttons ?? {
      AnyView(
        Button("OK") { }
      )
    }
  }

  init(error: Error) {
    self.init(title: "Error", subtitle: error.localizedDescription)
  }
}

extension View {

  @ViewBuilder
  func showCustomAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {
    switch type {
    case .alert:
      self
        .alert(
          alert.wrappedValue?.title ?? "",
          isPresented: Binding(ifNotNil: alert),
          actions: { alert.wrappedValue?.buttons() },
          message: {
            if let subtitle = alert.wrappedValue?.subtitle {
              Text(subtitle)
            }
          }
        )
    case .confirmationDialog:
      self
        .confirmationDialog(
          alert.wrappedValue?.title ?? "",
          isPresented: Binding(ifNotNil: alert),
          actions: { alert.wrappedValue?.buttons() },
          message: {
            if let subtitle = alert.wrappedValue?.subtitle {
              Text(subtitle)
            }
          }
        )
    }
  }

}
