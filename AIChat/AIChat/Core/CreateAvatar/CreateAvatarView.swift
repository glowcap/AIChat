//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct CreateAvatarView: View {

  @Environment(\.dismiss) var dismiss

  @State private var avatarName: String = ""
  @State private var avatarType: AvatarType = .default
  @State private var avatarAction: AvatarAction = .default
  @State private var avatarLocation: AvatarLocation = .default

  @State private var isGeneratingAvatar: Bool = false
  @State private var generatedImage: UIImage?

  @State private var isSaving: Bool = false

  var prefix: String {
    avatarType.startsWithVowel ? "an" : "a"
  }

  var body: some View {
    NavigationStack {
      List {
        nameSection
        attributesSection
        imageSection
        saveSection
      }
      .navigationTitle("Create Avatar")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          backButton
        }
      }
    }
  }

}

// MARK: - Subviews

private extension CreateAvatarView {

  var nameSection: some View {
    Section {
      TextField("", text: $avatarName)
    } header: {
      Text("Name your avatar")
    }
  }

  var attributesSection: some View {
    Section {
      Picker(selection: $avatarType) {
        ForEach(AvatarType.allCases, id: \.self) { type in
          Text(type.rawValue.capitalized)
        }
      } label: {
        Text("is \(prefix)...")
      }

      Picker(selection: $avatarAction) {
        ForEach(AvatarAction.allCases, id: \.self) { type in
          Text(type.rawValue.capitalized)
        }
      } label: {
        Text("that is...")
      }

      Picker(selection: $avatarLocation) {
        ForEach(AvatarLocation.allCases, id: \.self) { type in
          Text(type.rawValue.capitalized)
        }
      } label: {
        Text("in the...")
      }

    } header: {
      Text("Attributes")
    }
  }

  var imageSection: some View {
    Section {
      HStack(alignment: .top, spacing: 8) {
        ZStack {
          Text("Generate Image")
            .underline()
            .foregroundStyle(.accent)
            .anyButton(action: onGenerateImagePressed)
            .opacity(isGeneratingAvatar ? 0 : 1)

          ProgressView()
            .tint(.accentColor)
            .opacity(isGeneratingAvatar ? 1 : 0)
        }
        .disabled(isGeneratingAvatar || avatarName.isEmpty)

        Circle()
          .fill(Color.secondary.opacity(0.5))
          .overlay(
            ZStack {
              if let generatedImage {
                Image(uiImage: generatedImage)
                  .resizable()
                  .scaledToFill()
              }
            }
              .padding(24)
          )
          .clipShape(Circle())
      }
      .removeListRowFormatting()
    }
  }

  var saveSection: some View {
    Section {
      AsyncCTAButton(
        title: "Save",
        inProgress: isSaving,
        action: onSavePressed
      )
      .removeListRowFormatting()
      .padding(.top, 24)
      .opacity(generatedImage == nil ? 0.5 : 1.0)
      .disabled(generatedImage == nil)
    }
  }

  var backButton: some View {
    Image(systemName: "xmark")
      .font(.title2)
      .fontWeight(.semibold)
      .foregroundStyle(.accent)
      .anyButton(action: onBackButtonPressed)
  }

}

// MARK: - Private functions

private extension CreateAvatarView {

  func onBackButtonPressed() {
    dismiss()
  }

  func onGenerateImagePressed() {
    isGeneratingAvatar = true

    Task {
      try? await Task.sleep(for: .seconds(2))
      generatedImage = UIImage(systemName: "person.fill")
      isGeneratingAvatar = false
    }
  }

  func onSavePressed() {
    isSaving = true

    Task {
      try? await Task.sleep(for: .seconds(2))
      isSaving = false
      dismiss()
    }
  }

}

#Preview {
  CreateAvatarView()
}
