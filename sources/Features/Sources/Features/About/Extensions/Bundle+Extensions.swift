//
//  File.swift
//  
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

extension Bundle {
    // swiftlint:disable force_cast
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    var appVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

    var appBuild: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    // swiftlint:enable force_cast
}
