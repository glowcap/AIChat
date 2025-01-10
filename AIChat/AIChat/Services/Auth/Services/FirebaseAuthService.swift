//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Daymein Gregorio on 1/7/25.
//

import FirebaseAuth
import Foundation
import SignInAppleAsync

struct FirebaseAuthService: AuthService {

  typealias AuthInfo = (user: UserAuthInfo, isNewUser: Bool)

  func addAuthenticatedUserListener(
    onListenerAttached: (any NSObjectProtocol) -> Void
  ) -> AsyncStream<UserAuthInfo?> {
    AsyncStream { continuation in
      let listener = Auth.auth().addStateDidChangeListener { _, currentUser in
        if let currentUser {
          let user = UserAuthInfo(user: currentUser)
          continuation.yield(user)
        } else {
          continuation.yield(nil)
        }
      }
      onListenerAttached(listener)
    }
  }

  func getAuthenticatedUser() -> UserAuthInfo? {
    if let user = Auth.auth().currentUser {
      return UserAuthInfo(user: user)
    }
    return nil
  }

  func signInAnonymously() async throws -> AuthInfo {
    let result = try await Auth.auth().signInAnonymously()
    return result.asAuthInfo
  }

  func signInApple() async throws -> AuthInfo {
    let helper = await SignInWithAppleHelper()
    let response = try await helper.signIn()

    let credential = OAuthProvider.credential(
      providerID: AuthProviderID.apple,
      idToken: response.token,
      rawNonce: response.nonce
    )

    if let user = Auth.auth().currentUser, user.isAnonymous {
      do {
        // Try to link to existing anonymous account
        let result = try await user.link(with: credential)
        return result.asAuthInfo
      } catch let error as NSError {
        if let result = try await attemptSignInWithAnonymousLinkError(error) {
          return result.asAuthInfo
        }
      }
    }

    // Else, sign in to a new account
    let result = try await Auth.auth().signIn(with: credential)
    return result.asAuthInfo
  }

  func signOut() throws {
    try Auth.auth().signOut()
  }

  func deleteAccount() async throws {
    guard let user = Auth.auth().currentUser
    else { throw AuthError.userNotFound }

    try await user.delete()
  }

  enum AuthError: LocalizedError {
    case userNotFound

    var errorDescription: String? {
      switch self {
      case .userNotFound:
        return "Current authenticated user not found."
      }
    }
  }

}

// MARK: - Private functions

private extension FirebaseAuthService {

  // Two types of AuthErrorCodes provide an updated credential key to
  // allow signin https://github.com/invertase/react-native-apple-authentication/issues/272
  func attemptSignInWithAnonymousLinkError(_ error: NSError) async throws -> AuthDataResult? {
    let authError = AuthErrorCode(rawValue: error.code)
    switch authError {
    case .providerAlreadyLinked, .credentialAlreadyInUse:
      let updatedCredentialKey = "FIRAuthErrorUserInfoUpdatedCredentialKey"
      if let secondaryCredential = error.userInfo[updatedCredentialKey] as? AuthCredential {
        let result = try await Auth.auth().signIn(with: secondaryCredential)
        return result
      }
    default: break
    }
    return nil
  }

}

// MARK: - AuthDataResult Ext

private extension AuthDataResult {

  var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
    let user = UserAuthInfo(user: user)
    let isNewUser = additionalUserInfo?.isNewUser ?? true

    return (user, isNewUser)
  }

}
