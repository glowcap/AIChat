//
//  WelcomeView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/28/24.
//

import SwiftUI

struct WelcomeView: View {

  var body: some View {
    NavigationStack {
      VStack {
        Text("Welcome!")
          .frame(maxHeight: .infinity)
        NavigationLink {
          CompletedView()
        } label: {
          Text("Get Started")
            .ctaButton()
        }
      }
      .padding(16)
    }
  }

}

#Preview {
  WelcomeView()
}
