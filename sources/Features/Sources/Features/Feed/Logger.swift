//
//  File.swift
//  
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let feed = Logger(subsystem: subsystem, category: "feed")
}
