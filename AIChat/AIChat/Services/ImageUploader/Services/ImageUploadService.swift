//
//  ImageUploadService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import SwiftUI

protocol ImageUploadService {
  func uploadImage(_ image: UIImage, path: String) async throws -> URL
}

enum ImageUploaderError: LocalizedError {
  case invalidData
  case invalidURL
}
