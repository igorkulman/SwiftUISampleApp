//
//  File.swift
//  
//
//  Created by Igor Kulman on 27.07.2024.
//

import Foundation
import FeedKit

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
            description: item.content?.value?.sanitized,
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
            description: item.description?.sanitized,
            link: link,
            pubDate: item.pubDate
        )
    }
}
