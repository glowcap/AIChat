//
//  FirebaseAvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import Foundation
import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseAvatarService: RemoteAvatarService {

  var collection: CollectionReference = Firestore.firestore().collection("avatars")

  func createAvatar(_ avatar: AvatarModel, image: UIImage) async throws {
    // upload image
    let path = "avatars/\(avatar.avatarId)"
    let url = try await FirebaseImageUploadService().uploadImage(image, path: path)

    // upload avatar
    var avatar = avatar
    avatar.updateProfileImageName(url.absoluteString)

    try collection.document(avatar.avatarId).setData(from: avatar, merge: true)
  }

  func getAvatar(id: String) async throws -> AvatarModel {
    try await collection.getDocument(id: id)
  }

  func getFeaturedAvatars() async throws -> [AvatarModel] {
    try await collection
      .limit(to: 50)
      .getAllDocuments()
      .shuffled()
      .first(upTo: 5) ?? []
  }

  func getPopularAvatars() async throws -> [AvatarModel] {
    try await collection
      .order(by: AvatarModel.CodingKeys.clickCount.rawValue, descending: true)
      .limit(to: 200)
      .getAllDocuments()
  }

  func getAvatars(category: AvatarType) async throws -> [AvatarModel] {
    try await collection
      .whereField(AvatarModel.CodingKeys.avatarType.rawValue, isEqualTo: category.rawValue)
      .limit(to: 200)
      .getAllDocuments()
  }

  func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
    try await collection
      .whereField(AvatarModel.CodingKeys.authorId.rawValue, isEqualTo: userId)
      .order(by: AvatarModel.CodingKeys.dateCreated.rawValue, descending: true)
      .getAllDocuments()
  }

  func incrementAvatarClickCount(avatarId: String) async throws {
    try await collection.document(avatarId).updateData([
      AvatarModel.CodingKeys.clickCount.rawValue: FieldValue.increment(1.0)
    ])
  }

}
