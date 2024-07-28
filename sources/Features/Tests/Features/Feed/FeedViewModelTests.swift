//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Core
@testable import Feed
import Foundation
import XCTest

final class FeedViewModelTests: XCTestCase {
    func testNavigation() {
        var target: FeedView.NavigationTarget? = nil
        let viewModel = FeedViewModel(settings: .mock(selected: .mock), feed: .mock) {
            target = $0
        }
        XCTAssertNil(target)

        viewModel.showAbout()
        XCTAssertEqual(target, .about)

        viewModel.showDetail(item: .mock)
        XCTAssertEqual(target, .item(.mock))
    }

    func testLoading() async {
        let viewModel = FeedViewModel(settings: .mock(selected: .mock), feed: .mock) { _ in  }
        XCTAssertEqual(viewModel.state, .loading)

        await viewModel.load()
        XCTAssertEqual(viewModel.state, .loaded(data: [
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
        ]))
    }

    func testError() async {
        let viewModel = FeedViewModel(settings: .mock(selected: .mock), feed: .mock(error: .emptyFeed)) { _ in  }
        XCTAssertEqual(viewModel.state, .loading)

        await viewModel.load()
        XCTAssertEqual(viewModel.state, .error(data: [], error: FeedError.emptyFeed))
    }
}

extension FeedView.NavigationTarget: Equatable {
    public static func == (lhs: FeedView.NavigationTarget, rhs: FeedView.NavigationTarget) -> Bool {
        switch (lhs, rhs) {
        case (.about, .about):
            return true
        case let (.item(lItem), .item(rItem)):
            return lItem.link == rItem.link
        default:
            return false
        }
    }
}

extension ScreenState<[RssItem]>: Equatable {
    public static func == (lhs: Core.ScreenState<T>, rhs: Core.ScreenState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading,.loading):
            return true
        case let (.loaded(lItem), .loaded(rItem)):
            return lItem == rItem
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
