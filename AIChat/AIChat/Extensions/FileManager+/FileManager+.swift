//
//  FileManager+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/12/25.
//

import Foundation

extension FileManager {

  static func saveDocument<T: Codable>(key: String, value: T) throws {
    let data = try JSONEncoder().encode(value)
    let url = try getDocumentURL(for: key)
    try data.write(to: url, options: .atomic)
  }

  static func getDocument<T: Codable>(key: String) throws -> T? {
    let url = try getDocumentURL(for: key)
    let data = try Data(contentsOf: url)
    return try JSONDecoder().decode(T.self, from: data)
  }

  static func getDocumentURL(for key: String) throws -> URL {
    guard let path = FileManager.default
      .urls(for: .documentDirectory, in: .userDomainMask)
      .first
    else { throw FileManagerError.documentDirectoryURLNotFound }
    return path.appendingPathComponent("\(key).txt")
  }

  enum FileManagerError: LocalizedError {
    case documentDirectoryURLNotFound
  }

}
