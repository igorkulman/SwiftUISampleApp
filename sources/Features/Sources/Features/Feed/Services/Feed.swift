//
//  Feed.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Core
import FeedKit
import Foundation
import OSLog

public enum FeedError: Error {
    case emptyFeed
}

public struct Feed {
    public var get: (RssSource) async throws -> [RssItem]
}

extension Feed {
    @MainActor
    public static let live: Self = Feed(get: { source in
        Logger.feed.debug("Loading \(source.rss.absoluteString)")
        let feed = try await FeedKit.Feed(url: source.rss)
        switch feed {
        case let .atom(feed):
            guard let entries = feed.entries, !entries.isEmpty else {
                throw FeedError.emptyFeed
            }
            return entries.compactMap({ RssItem(item: $0) })
        case let .rss(feed):
            guard let items = feed.channel?.items, !items.isEmpty else {
                throw FeedError.emptyFeed
            }
            return items.compactMap({ RssItem(item: $0) })
        case let .json(feed):
            guard let items = feed.items, !items.isEmpty else {
                throw FeedError.emptyFeed
            }
            return items.compactMap({ RssItem(item: $0) })
        }
    })
}

#if DEBUG
// swiftlint:disable line_length
extension Feed {
    @MainActor
    public static var mock: Self = Feed(get: { _ in
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return [
            .init(
                title: "Links for the intellectually curious, ranked by readers.",
                description: "Comments",
                link: URL(string: "https://github.com/nodejs/node/pull/53725")!,
                pubDate: Date(timeIntervalSince1970: 0)
            ),
            .init(
                title: "Anyone can access deleted and private repository data on GitHub",
                description: "Comments",
                link: URL(string: "https://trufflesecurity.com/blog/anyone-can-access-deleted-and-private-repo-data-github")!,
                pubDate: Date(timeIntervalSince1970: 0)
            ),
            .init(
                title: "My Favorite Algorithm: Linear Time Median Finding (2018)",
                description: "Comments",
                link: URL(string: "https://rcoh.me/posts/linear-time-median-finding/")!,
                pubDate: Date(timeIntervalSince1970: 0)
            ),
            .init(
                title: "Generating sudokus for fun and no profit",
                description: "Comments",
                link: URL(string: "https://tn1ck.com/blog/how-to-generate-sudokus")!,
                pubDate: Date(timeIntervalSince1970: 0)
            )
        ]
    })
    public static func mock(error: FeedError) -> Self {
        Feed(get: { _ in
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            throw error
        })
    }
}
// swiftlint:enable line_length
#endif
