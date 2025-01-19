//
//  AIChatRole.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/19/25.
//

import Foundation
import OpenAI

enum AIChatRole {
  case assistant, system, tool, user

  init(openAIRole: ChatQuery.ChatCompletionMessageParam.Role) {
    switch openAIRole {
    case .assistant: self = .assistant
    case .system: self = .system
    case .tool: self = .tool
    case .user: self = .user
    }
  }

  var openAIRole: ChatQuery.ChatCompletionMessageParam.Role {
    switch self {
    case .assistant: .assistant
    case .system: .system
    case .tool: .tool
    case .user: .user
    }
  }
}
