//
//  RSSSource.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation

struct RssSource: Codable, Hashable {
    let title: String
    let url: URL
    let rss: URL
    let icon: String?
}

#if DEBUG
extension RssSource {
    static var mock: Self = RssSource(
        title: "Hacker News",
        url: URL(string: "https://news.ycombinator.com")!,
        rss: URL(string: "https://news.ycombinator.com/rss")!,
        icon: "https://upload.wikimedia.org/wikipedia/commons/d/d5/Y_Combinator_Logo_400.gif"
    )
}
#endif
