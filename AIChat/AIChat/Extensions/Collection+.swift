//
//  Collection+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/16/25.
//

import Foundation

extension Collection {

  func first(upTo value: Int) -> [Element]? {
    isEmpty ? nil : Array(prefix(value))
  }

  func last(upTo value: Int) -> [Element]? {
    isEmpty ? nil : Array(prefix(value))
  }

}
