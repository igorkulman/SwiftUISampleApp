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
    @StateObject private var viewModel: ViewModel

    init(settings: Settings, feed: Feed, onNavigation: @escaping (NavigationTarget) -> Void) {
        _viewModel = StateObject(
            wrappedValue: ViewModel(
                settings: settings,
                feed: feed,
                onNavigation: onNavigation
            )
        )
    }

    var body: some View {
        ZStack {
            List(viewModel.items, id: \.title) { item in
                ItemRow(item: item) {
                    viewModel.showDetail(item: item)
                }
            }.refreshable {
                Task {
                    await viewModel.load()
                }
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }.errorAlert(error: $viewModel.error)
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

extension FeedView {
    @MainActor
    private class ViewModel: ObservableObject {
        var title: String {
            source.title
        }
        @Published var items: [RssItem] = []
        @Published var isLoading: Bool = true
        @Published var error: Error?

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
                items = try await feed.get(source)
            } catch {
                self.error = error
            }
            isLoading = false
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
