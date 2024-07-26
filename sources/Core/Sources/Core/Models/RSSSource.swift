//
//  RSSSource.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation

public struct RssSource: Codable, Hashable {
    public let title: String
    public let url: URL
    public let rss: URL
    public let icon: String?
}

#if DEBUG
extension RssSource {
    public static var mock: Self = RssSource(
        title: "Hacker News",
        url: URL(string: "https://news.ycombinator.com")!,
        rss: URL(string: "https://news.ycombinator.com/rss")!,
        icon: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Y_Combinator_Logo_400.gif"
    )
}
#endif
