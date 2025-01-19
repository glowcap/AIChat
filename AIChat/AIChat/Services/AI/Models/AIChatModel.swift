//
//  AIChatModel.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/19/25.
//

import Foundation
import OpenAI

struct AIChatModel {
  let role: AIChatRole
  let message: String

  init(role: AIChatRole, content: String) {
    self.role = role
    self.message = content
  }

  init?(chat: ChatResult.Choice.ChatCompletionMessage) {
    self.role = AIChatRole(openAIRole: chat.role)

    guard let string = chat.content?.string else { return nil }
    self.message = string
  }

  func toOpenAIModel() -> ChatQuery.ChatCompletionMessageParam? {
    ChatQuery.ChatCompletionMessageParam(
      role: role.openAIRole,
      content: [OpenAIChatContent.chatCompletionContentPartTextParam(OpenAIChatText(text: message))]
    )
  }

}
