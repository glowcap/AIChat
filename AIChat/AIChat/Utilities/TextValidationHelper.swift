//
//  TextValidationHelper.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import Foundation

struct TextValidationHelper {

  enum TextValidationError: LocalizedError {
    case minCharacterCount(min: Int)
    case profanityCheck

    var errorDescription: String? {
      switch self {
      case .minCharacterCount(let min):
        "Messages require a minimum of \(min) characters"
      case .profanityCheck:
        "Profanity detected. Rephrase your message"
      }
    }
  }

  static func textIsValid(_ text: String, minimimCharacterCount: Int = 4) throws {
    let minCharacterCount = minimimCharacterCount
    guard text.count >= minCharacterCount
    else {
      throw TextValidationError
        .minCharacterCount(min: minCharacterCount)
    }

    let textArr = text.lowercased().components(separatedBy: .whitespacesAndNewlines)

    for word in textArr where Constants.profanity.contains(word) {
      throw TextValidationError.profanityCheck
    }
    // 👍 all good 👍
  }

}
