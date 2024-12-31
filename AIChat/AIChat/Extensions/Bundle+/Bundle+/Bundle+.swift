//
//  Bundle+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import Foundation

extension Bundle {

  var releaseVersionNumber: String {
      infoDictionary?["CFBundleShortVersionString"] as? String ?? "Not Found"
  }
  var buildVersionNumber: String {
      infoDictionary?["CFBundleVersion"] as? String ?? "Not Found"
  }

}
