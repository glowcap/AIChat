//
//  CategoryCellView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/30/24.
//

import SwiftUI

struct CategoryCellView: View {

  var title: AttributedString = "Aliens"
  var imageName: String = Constants.randomImage
  var font: Font = .title2
  var cornerRadius: CGFloat = 16

  var body: some View {
    ZStack(alignment: .bottomLeading) {
      ImageLoaderView(urlString: imageName)
        .aspectRatio(1, contentMode: .fit)
    }
    .overlay(alignment: .bottomLeading) {
      Text(title)
        .font(font)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .textBackgroundGradient()
    }
    .cornerRadius(cornerRadius)
  }

}

#Preview {
  VStack {
    CategoryCellView()
      .frame(width: 140)
    CategoryCellView()
      .frame(width: 200)
    CategoryCellView()
      .frame(width: 300)
  }

}
