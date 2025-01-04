//
//  View+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

extension View {
  
  /// Upon satisfying the condition, the transform function is performed to redraw the view
  /// - Parameters:
  ///   - condition: Condition to be met to trigger transform function
  ///   - transform: Function that takes `Self` and returns some View
  /// - Returns: If condition is met, returns `some View` else returns `self`
  /// - Important: Use only if absolutely necessary as triggering the  `transform` function will
  ///             cause `Self` to be completely redrawn which is computationally heavy
  @ViewBuilder
  func ifSatisfiesCondition(_ condition: Bool, transform: (Self) -> some View) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }

}
