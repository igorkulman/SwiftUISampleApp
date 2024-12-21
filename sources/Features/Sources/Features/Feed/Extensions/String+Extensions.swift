//
//  File.swift
//  Features
//
//  Created by Igor Kulman on 21.12.2024.
//

import Foundation

extension String {
    var sanitized: String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
