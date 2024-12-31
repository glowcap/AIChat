//
//  CustomListCellView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import SwiftUI

struct CustomListCellView: View {

  var imageName: String? = Constants.randomImage
  var title: String? = AvatarModel.mock.name
  var subtitle: String? = AvatarModel.mock.description

  var body: some View {
    HStack(spacing: 8) {
      ZStack {
        if let imageName {
          ImageLoaderView(urlString: imageName)
        } else {
          Rectangle()
            .fill(.secondary.opacity(0.5))
        }
      }
      .aspectRatio(1, contentMode: .fit)
      .frame(height: 60)
      .cornerRadius(16)
      VStack(alignment: .leading, spacing: 4) {
        if let title {
          Text(title)
            .font(.headline)
            .fontWeight(.semibold)
        }
        if let subtitle {
          Text(subtitle)
            .font(.subheadline)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(12)
    .padding(.vertical, 4)
    .background(Color(uiColor: .systemBackground))
  }
}

#Preview {
  List {
    CustomListCellView()
    CustomListCellView()
    CustomListCellView(
      imageName: nil,
      title: AvatarModel.mock.name,
      subtitle: AvatarModel.mock.description
    )
  }

}
