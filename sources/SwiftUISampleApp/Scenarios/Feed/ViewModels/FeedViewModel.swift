//
//  FeedViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

@Observable
final class FeedViewModel {
    enum NavigationTarget {
        case item(RssItem)
        case about
    }

    var title: String {
        source.title
    }
    var state: ScreenState<[RssItem]> = .loading

    private let onNavigation: (NavigationTarget) -> Void
    private let feed: Feed
    private let source: RssSource

    init(settings: Settings, feed: Feed, onNavigation: @escaping (NavigationTarget) -> Void) {
        guard let source = settings.get() else {
            fatalError()
        }

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
}
