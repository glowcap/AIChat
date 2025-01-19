//
//  OpenAIService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import OpenAI
import SwiftUI

typealias OpenAIChatContent = ChatQuery.ChatCompletionMessageParam
                              .ChatCompletionUserMessageParam.Content.VisionContent
typealias OpenAIChatText = OpenAIChatContent.ChatCompletionContentPartTextParam

struct OpenAIService: AIService {

  var openAI: OpenAI {
    OpenAI(apiToken: Constants.openAiToken)
  }

  /// 🙋🏻‍♀️ Will be moved to server
  func generateImage(input: String) async throws -> UIImage {

    // default model - GPT4
    let query = ImagesQuery(
      prompt: input,
      n: 1,
      quality: .hd,
      responseFormat: .b64_json,
      size: ._512,
      style: .natural,
      user: nil
    )
    let result = try await openAI.images(query: query)

    guard let b64Json = result.data.first?.b64Json,
          let data = Data(base64Encoded: b64Json),
          let image = UIImage(data: data)
    else {
      throw AIManager.AIError.invalidResponse
    }

    return image
  }

  func generateText(forChat chat: [AIChatModel]) async throws -> AIChatModel {
    let messages = chat.compactMap { $0.toOpenAIModel() }
    let query = ChatQuery(messages: messages, model: .gpt3_5Turbo)
    let result = try await openAI.chats(query: query)

    guard
      let chat = result.choices.first?.message,
      let model = AIChatModel(chat: chat)
    else {
      throw AIManager.AIError.invalidResponse
    }
    return model
  }

}
