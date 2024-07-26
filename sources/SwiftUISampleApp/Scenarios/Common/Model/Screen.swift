//
//  Screen.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

enum Screen: Identifiable, Hashable {
    case setup
    case feed
    case item(RssItem)
    case about
    case libraries

    var id: String {
        switch self {
        case .setup:
            return "setup"
        case .feed:
            return "feed"
        case .about:
            return "about"
        case .libraries:
            return "libraries"
        case .item(let item):
            return item.link.absoluteString
        }
    }
}
