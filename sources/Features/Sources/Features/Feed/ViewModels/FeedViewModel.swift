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
    @ObservationIgnored @Dependency(\.feed) private var feed: Feed
    private let source: RssSource

    init(source: RssSource, onNavigation: @escaping (FeedView.NavigationTarget) -> Void) {
        self.onNavigation = onNavigation
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
