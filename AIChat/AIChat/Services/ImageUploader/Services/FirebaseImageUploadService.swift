//
//  FirebaseImageUploadService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import FirebaseStorage
import SwiftUI

struct FirebaseImageUploadService {

  func uploadImage(_ image: UIImage, path: String) async throws -> URL {
    guard let data = image.jpegData(compressionQuality: 0.8) else {
      throw ImageUploaderError.invalidData
    }
    try await saveImageData(data, path: path)
    return try await imageReference(path: path).downloadURL()
  }

}

private extension FirebaseImageUploadService {

  func imageReference(path: String) -> StorageReference {
    Storage.storage().reference(withPath: "\(path).jpg")
  }

  @discardableResult
  func saveImageData(_ data: Data, path: String) async throws -> URL {
    let meta = StorageMetadata()
    meta.contentType = "image/jpeg"

    let returnedMeta = try await imageReference(path: path).putDataAsync(data, metadata: meta)

    guard let returnedPath = returnedMeta.path, let url = URL(string: returnedPath) else {
      throw ImageUploaderError.invalidURL
    }
    return url
  }

}
