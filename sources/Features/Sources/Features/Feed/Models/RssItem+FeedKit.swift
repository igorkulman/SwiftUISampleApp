//
//  File.swift
//  
//
//  Created by Igor Kulman on 27.07.2024.
//

import Foundation
import FeedKit

private let sanitize = { (string: String?) -> String? in
    return string?
        .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

extension RssItem {
    init?(item: AtomFeedEntry) {
        guard let title = item.title,
              let link = item.links?
                .compactMap({ $0.attributes?.href })
                .first.flatMap({ URL(string: $0) }) else {
            return nil
        }
        self.init(
            title: title,
            description: sanitize(item.content?.value),
            link: link,
            pubDate: item.updated
        )
    }

    init?(item: RSSFeedItem) {
        guard let title = item.title,
              let link = item.link.flatMap({ URL(string: $0) }) else {
            return nil
        }
        self.init(
            title: title,
            description: sanitize(item.description),
            link: link,
            pubDate: item.pubDate
        )
    }
}
