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
    public static var live: Self = Feed(get: { source in
        Logger.feed.debug("Fetching RSS Feed from \(source.rss)")

        let parser = FeedParser(URL: source.rss)
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[RssItem], Error>) in
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { result in
                switch result {
                case let .success(feed):
                    if let rssItems = feed.rssFeed?.items?.compactMap({ RssItem(item: $0) }) {
                        Logger.feed.debug("Got \(rssItems.count) RSS items")
                        continuation.resume(returning: rssItems)
                        return
                    }

                    if let atomItems = feed.atomFeed?.entries?.compactMap({ RssItem(item: $0) }) {
                        Logger.feed.debug("Got \(atomItems.count) Atom items")
                        continuation.resume(returning: atomItems)
                    }

                    Logger.feed.error("RSS Feed return no items")
                    continuation.resume(throwing: FeedError.emptyFeed)
                case let .failure(error):
                    Logger.feed.error("Fetching RSS Feed failed [error: \(error.localizedDescription)]")
                    continuation.resume(throwing: error)
                }
            }
        }
    })
}

#if DEBUG
// swiftlint:disable line_length
extension Feed {
    public static var mock: Self = Feed(get: { _ in
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return [
            .init(
                title: "Links for the intellectually curious, ranked by readers.",
                description: "Comments",
                link: URL(string: "https://github.com/nodejs/node/pull/53725")!,
                pubDate: Date()
            ),
            .init(
                title: "Anyone can access deleted and private repository data on GitHub",
                description: "Comments",
                link: URL(string: "https://trufflesecurity.com/blog/anyone-can-access-deleted-and-private-repo-data-github")!,
                pubDate: Date()
            ),
            .init(
                title: "My Favorite Algorithm: Linear Time Median Finding (2018)",
                description: "Comments",
                link: URL(string: "https://rcoh.me/posts/linear-time-median-finding/")!,
                pubDate: Date()
            ),
            .init(
                title: "Generating sudokus for fun and no profit",
                description: "Comments",
                link: URL(string: "https://tn1ck.com/blog/how-to-generate-sudokus")!,
                pubDate: Date()
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
