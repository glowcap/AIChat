//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import SwiftUI

struct CreateAvatarView: View {

  @Environment(AIManager.self) var aiManager
  @Environment(AuthManager.self) var authManager
  @Environment(AvatarManager.self) var avatarManager
  @Environment(\.dismiss) var dismiss

  @State private var avatarName: String = ""
  @State private var avatarType: AvatarType = .default
  @State private var avatarAction: AvatarAction = .default
  @State private var avatarLocation: AvatarLocation = .default

  @State private var isGeneratingAvatar: Bool = false
  @State private var generatedImage: UIImage?

  @State private var isSaving: Bool = false
  @State private var showAlert: AnyAppAlert?

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
      .showCustomAlert(alert: $showAlert)
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
            .tint(.accent)
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
      do {
        let prompt = AvatarDescriptionBuilder(
          avatarType: avatarType,
          avatarAction: avatarAction,
          avatarLocation: avatarLocation
        ).avatarDescription

        generatedImage = try await aiManager.generateImage(input: prompt)
      } catch {
        print("⛔️Error generating image: \(error.localizedDescription)")
      }
      isGeneratingAvatar = false
    }
  }

  func onSavePressed() {
    guard let generatedImage else { return }
    isSaving = true

    Task {

      do {
        try TextValidationHelper.textIsValid(avatarName, minimimCharacterCount: 3)
        let uid = try authManager.getAuthId()

        let avatar = AvatarModel(
          avatarId: UUID().uuidString,
          name: avatarName,
          avatarType: avatarType,
          avatarAction: avatarAction,
          avatarLocation: avatarLocation,
          profileImageName: nil,
          authorId: uid,
          dateCreated: .now
        )

        try await avatarManager.createAvatar(avatar, image: generatedImage)

        dismiss()

      } catch {
        showAlert = AnyAppAlert(error: error)
      }
      isSaving = false
    }
  }

}

#Preview {
  CreateAvatarView()
    .environment(AIManager(service: MockAIService()))
    .environment(AvatarManager(service: MockAvatarService()))
    .environment(AuthManager(service: MockAuthService(user: .mock())))
}
