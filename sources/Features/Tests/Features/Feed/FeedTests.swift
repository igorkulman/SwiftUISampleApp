//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Core
@testable import Feed
import Foundation
import Testing

final class FeedTests {
    @Test
    func testFetchingValidFeed() async throws {
        let feed = Feed.live
        let items = try await feed.get(.mock)
        #expect(!items.isEmpty)
    }

    @Test
    func testFetchingInvalidFeed()  async throws {
        let feed = Feed.live
        var didFailWithError: Error?
        do {
            _ = try await feed.get(RssSource(title: "Google", url: URL(string: "https://www.google.com")!, rss: URL(string: "https://www.google.com")!, icon: nil))
        } catch {
            didFailWithError = error
        }

        #expect(didFailWithError != nil)
    }
}
