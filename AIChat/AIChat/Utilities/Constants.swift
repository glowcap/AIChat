//
//  Constants.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/29/24.
//

import Foundation

struct Constants {

  static let randomImage = "https://picsum.photos/600/600"
  static let privacyPolicyUrl = "https://apple.com"
  static let termsOfServiceUrl = "https://apple.com"

  static let profanity: [String] = [
    "shit", "bitch", "ass"
  ]

  /// API key for OpenAI
  /// - Important: You'll need to generate your own key at https://platform.openai.com/
  static let openAiToken = APIKeys.openAiKey

}
