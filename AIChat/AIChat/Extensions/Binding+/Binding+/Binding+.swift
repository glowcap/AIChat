//
//  Binding+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import SwiftUI

extension Binding where Value == Bool {

  init<T: Sendable>(ifNotNil value: Binding<T?>) {
    self.init {
      value.wrappedValue != nil
    } set: { newValue in
      if !newValue {
        value.wrappedValue = nil
      }
    }
  }

}
