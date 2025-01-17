//
//  SwiftDatLocalAvatarPersistence.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/17/25.
//

import SwiftData
import SwiftUI

struct SwiftDatLocalAvatarPersistence: LocalAvatarPersistence {

  private let container: ModelContainer

  private var context: ModelContext {
    container.mainContext
  }

  init() {
    do {
      self.container = try ModelContainer(for: AvatarEntity.self)
    } catch {
      fatalError("⛔️ Failed to initialize local Avatar persistence: \(error.localizedDescription)")
    }
  }

  func addRecentAvatar(_ avatar: AvatarModel) throws {
    let entity = AvatarEntity(from: avatar)
    container.mainContext.insert(entity)
    try container.mainContext.save()
  }

  func getRecentAvatars() throws -> [AvatarModel] {
    let descriptor = FetchDescriptor<AvatarEntity>(
      sortBy: [SortDescriptor(\.dateAdded, order: .reverse)]
    )
    let entities = try container.mainContext.fetch(descriptor)
    return entities.map { $0.toModel() }
  }

}
