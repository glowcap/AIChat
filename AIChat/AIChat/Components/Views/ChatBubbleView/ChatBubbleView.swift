//
//  ChatBubbleView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/1/25.
//

import SwiftUI

struct ChatBubbleView: View {

  var text: String = "This is a sample message"
  var textColor: Color = .primary
  var backgroundColor: Color = Color(uiColor: .systemGray5)
  var showImage: Bool = true
  var imageName: String?
  var onImagePressed: (() -> Void)?

  private let offset: CGFloat = 14

  var body: some View {
    HStack(alignment: .top, spacing: 8) {
      if showImage {
        avatarImageView
      }
      messageText
    }
    .padding(.bottom, showImage ? offset : 0)
  }

}

// MARK: - Subviews

private extension ChatBubbleView {

  var avatarImageView: some View {
    ZStack {
      if let imageName {
        ImageLoaderView(urlString: imageName)
          .anyButton { onImagePressed?() }
      } else {
        Rectangle()
          .fill(.secondary)
      }
    }
    .frame(width: 45, height: 45)
    .clipShape(Circle())
    .offset(y: offset)
  }

  var messageText: some View {
    Text(text)
      .font(.body)
      .foregroundStyle(textColor)
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(backgroundColor)
      .cornerRadius(6)
  }

}

#Preview {
  // swiftlint:disable line_length
  ScrollView {
    VStack(spacing: 16) {
      ChatBubbleView()
      ChatBubbleView(text: "This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines. This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines.")
      ChatBubbleView(
        textColor: .white,
        backgroundColor: .accent,
        showImage: false,
        imageName: nil
      )
      ChatBubbleView(
        text: "This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines. This is a message with a lot of text that wraps to mulitiple lines and must wrap to other lines.",
        textColor: .white,
        backgroundColor: .accent,
        showImage: false,
        imageName: nil
      )
    }
  }
  .padding(8)
  // swiftlint:enable line_length
}
