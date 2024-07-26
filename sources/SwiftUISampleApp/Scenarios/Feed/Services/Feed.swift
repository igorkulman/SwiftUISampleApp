//
//  Feed.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import FeedKit
import Foundation
import OSLog

enum FeedError: LocalizedError {
    case emptyFeed
}

struct Feed {
    var get: (RssSource) async throws -> [RssItem]
}

extension Feed {
    static var live: Self = Feed(get: { source in
        Logger.feed.debug("Fetching RSS Feed from \(source.rss)")

        let parser = FeedParser(URL: source.rss)
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[RssItem], Error>) in
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { result in
                switch result {
                case let .success(feed):
                    guard let rss = feed.rssFeed, let items = rss.items else {
                        Logger.feed.error("RSS Feed return no items")
                        continuation.resume(throwing: FeedError.emptyFeed)
                        return
                    }
                    let rssItems = items.compactMap { item -> RssItem? in
                        guard let title = item.title,
                              let link = item.link.flatMap({ URL(string: $0) }) else {
                            return nil
                        }
                        return RssItem(
                            title: title,
                            description: item.description?
                                .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil),
                            link: link,
                            pubDate: item.pubDate
                        )
                    }
                    continuation.resume(returning: rssItems)
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
    static var mock: Self = Feed(get: { _ in
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
    static func mock(error: FeedError) -> Self {
        Feed(get: { _ in
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            throw error
        })
    }
}
// swiftlint:enable line_length
#endif
