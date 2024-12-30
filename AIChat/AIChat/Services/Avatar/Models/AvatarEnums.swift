//
//  AvatarEnums.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import Foundation

enum AvatarType: String, CaseIterable, Hashable {
  case alien
  case bird
  case cat
  case dog
  case man
  case woman

  static var `default`: Self {
    .man
  }

  var categoryName: AttributedString {
    var string = AttributedString(localized: "\(self.rawValue.capitalized)")
    var morphology = Morphology()

    morphology.number = .plural
    string.inflect = InflectionRule(morphology: morphology)

    let formattedResult = string.inflected()
    return formattedResult
  }

}

enum AvatarAction: String {
  case crying
  case drinking
  case eating
  case fighting
  case shopping
  case sitting
  case skateboarding
  case smiling
  case studying
  case walking
  case working

  static var `default`: Self {
    .smiling
  }
}

enum AvatarLocation: String {
  case city
  case desert
  case forest
  case supermarket
  case park
  case space
  case store

  static var `default`: Self {
    .park
  }
}
