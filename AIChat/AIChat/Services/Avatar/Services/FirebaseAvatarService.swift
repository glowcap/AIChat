//
//  FirebaseAvatarService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/15/25.
//

import Foundation
import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseAvatarService: AvatarService {

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

}
