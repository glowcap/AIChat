//
//  MockAIService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import SwiftUI

struct MockAIService: AIService {

  func generateImage(input: String) async throws -> UIImage {
    try await Task.sleep(for: .seconds(2))
    return UIImage(systemName: "person.circle.fill")!
  }

}
