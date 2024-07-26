//
//  FeedView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation
import SwiftUI

struct FeedView: View {
    enum NavigationTarget {
        case item(RssItem)
        case about
    }
    @State private var viewModel: ViewModel

    init(settings: Settings, feed: Feed, onNavigation: @escaping (NavigationTarget) -> Void) {
        viewModel = ViewModel(
            settings: settings,
            feed: feed,
            onNavigation: onNavigation
        )
    }

    var body: some View {
        LoadableScreen($viewModel.state) { data in
            List(data, id: \.title) { item in
                ItemRow(item: item) {
                    viewModel.showDetail(item: item)
                }
            }.refreshable {
                Task {
                    await viewModel.load()
                }
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await viewModel.load()
            }
        }.toolbar {
            ToolbarItem {
                Button {
                    viewModel.showAbout()
                } label: {
                    Image(symbol: .info)
                }
            }
        }
    }
}

// MARK: View Model

extension FeedView {
    @Observable
    final class ViewModel {
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
}

#Preview("Success") {
    NavigationStack {
        FeedView(settings: .mock(selected: .mock), feed: .mock, onNavigation: { _ in })
    }
}
#Preview("Error") {
    NavigationStack {
        FeedView(settings: .mock(selected: .mock), feed: .mock(error: .emptyFeed), onNavigation: { _ in })
    }
}
