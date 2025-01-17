//
//  AIManager.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import SwiftUI

@MainActor
@Observable
class AIManager {

  private let service: AIService

  init(service: AIService) {
    self.service = service
  }

  func generateImage(input: String) async throws -> UIImage {
    try await service.generateImage(input: input)
  }

}