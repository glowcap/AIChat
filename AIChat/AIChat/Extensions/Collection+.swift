//
//  Collection+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/16/25.
//

import Foundation

extension Collection {

  func first(upTo value: Int) -> [Element]? {
    guard !isEmpty else { return nil }
    let maxItems = Swift.min(count, value)
    return Array(prefix(maxItems))
  }

  func last(upTo value: Int) -> [Element]? {
    guard !isEmpty else { return nil }
    let maxItems = Swift.min(count, value)
    return Array(suffix(maxItems))
  }

}
