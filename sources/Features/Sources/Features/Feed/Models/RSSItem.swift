//
//  RSSItem.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation

public struct RssItem: Hashable, Equatable {
    public let title: String
    public let description: String?
    public let link: URL
    public let pubDate: Date?
}

#if DEBUG
// swiftlint:disable line_length
extension RssItem {
    static var mock: Self {
        return .init(
            title: "Anyone can access deleted and private repository data on GitHub",
            description: "Comments",
            link: URL(string: "https://trufflesecurity.com/blog/anyone-can-access-deleted-and-private-repo-data-github")!,
            pubDate: Date()
        )
    }
}
// swiftlint:enable line_length
#endif
