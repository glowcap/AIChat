//
//  Bundle+.swift
//  AIChat
//
//  Created by Daymein Gregorio on 12/31/24.
//

import Foundation

extension Bundle {

  var appVersion: String {
      infoDictionary?["CFBundleShortVersionString"] as? String ?? "Not Found"
  }
  var buildVersion: String {
      infoDictionary?["CFBundleVersion"] as? String ?? "Not Found"
  }

}
