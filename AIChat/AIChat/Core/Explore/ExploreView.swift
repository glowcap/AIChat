//
//  ExploreView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct ExploreView: View {

  let avatar = AvatarModel.mock

  var body: some View {
    NavigationStack {
      HeroCellView(
        title: avatar.name,
        subtitle: avatar.avatarDescription,
        imageName: avatar.profileImageName
      )
      .frame(height: 200)
      .navigationTitle("Explore")
    }
  }
}

#Preview {
  ExploreView()
}
