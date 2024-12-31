//
//  ChatRowCellView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct ChatRowCellView: View {

  var imageName: String? = Constants.randomImage
  var headline: String? = "Alpha"
  var subheadline: String? = "The last message in the chat and it's a long one"
  var hasNewChat: Bool = true

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
      .frame(width: 50, height: 50)
      .clipShape(Circle())

      VStack(alignment: .leading, spacing: 4) {
        if let headline {
          Text(headline)
            .font(.headline)
        }

        if let subheadline {
          Text(subheadline)
            .font(.subheadline)
            .lineLimit(1)
            .truncationMode(.tail)
            .foregroundStyle(.secondary)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      if hasNewChat {
        Text("NEW")
          .font(.caption)
          .foregroundStyle(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 6)
          .background(.blue)
          .cornerRadius(6)
      }
    }
    .padding(.vertical, 12)
    .padding(.horizontal, 8)
    .background(Color(uiColor: .systemBackground))
  }

}

#Preview {
  List {
    ChatRowCellView()
      .removeListRowFormatting()

    ChatRowCellView(hasNewChat: false)
      .removeListRowFormatting()

    ChatRowCellView(imageName: nil)
      .removeListRowFormatting()

    ChatRowCellView(headline: nil)
      .removeListRowFormatting()

    ChatRowCellView(subheadline: nil)
      .removeListRowFormatting()

    ChatRowCellView(headline: nil, hasNewChat: false)
      .removeListRowFormatting()

    ChatRowCellView(subheadline: nil, hasNewChat: false)
      .removeListRowFormatting()

  }
}
