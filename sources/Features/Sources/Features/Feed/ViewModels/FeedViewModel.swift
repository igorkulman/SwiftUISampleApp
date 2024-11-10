//
//  FeedViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Core
import Foundation

@Observable
final class FeedViewModel {
    var title: String {
        source.title
    }
    var state: ScreenState<[RssItem]> = .loading

    private let onNavigation: (FeedView.NavigationTarget) -> Void
    private let feed: Feed
    private let source: RssSource

    init(source: RssSource, feed: Feed, onNavigation: @escaping (FeedView.NavigationTarget) -> Void) {
        self.onNavigation = onNavigation
        self.feed = feed
        self.source = source
    }

    func load() async {
        do {
            let items = try await feed.get(source)
            state = .loaded(data: items)
        } catch {
            state.toError(error: error)
        }
    }

    func showDetail(item: RssItem) {
        onNavigation(.item(item))
    }

    func showAbout() {
        onNavigation(.about)
    }

    func showSettings() {
        onNavigation(.settings)
    }
}
