//
//  AIService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import SwiftUI

protocol AIService: Sendable {
  func generateImage(input: String) async throws -> UIImage
}
