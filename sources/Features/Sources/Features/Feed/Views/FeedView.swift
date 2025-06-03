//
//  FeedView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Core
import Foundation
import SwiftUI

public struct FeedView: View {
    public enum NavigationTarget {
        case item(RssItem)
        case about
        case settings
    }

    @State var state: ScreenState<[RssItem]> = .loading

    let onNavigation: (NavigationTarget) -> Void
    let source: RssSource
    let feed: Feed

    public init(
        source: RssSource,
        feed: Feed,
        onNavigation: @escaping (NavigationTarget) -> Void
    ) {
        self.onNavigation = onNavigation
        self.source = source
        self.feed = feed
    }

    public var body: some View {
        LoadableScreen($state) { data in
            List(data, id: \.title) { item in
                ItemRow(item: item) {
                   onNavigation(.item(item))
                }
            }.refreshable {
                await load()
            }
        }
        .navigationTitle(source.title)
        .navigationBarBackButtonHidden(true)
        .task {
            await load()
        }.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    onNavigation(.settings)
                } label: {
                    Image(symbol: .gear)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onNavigation(.about)
                } label: {
                    Image(symbol: .info)
                }
            }
        }
    }

    private func load() async {
        do {
            let items = try await feed.get(source)
            state = .loaded(data: items)
        } catch {
            state.toError(error: error)
        }
    }
}

#Preview("Success") {
    NavigationStack {
        FeedView(source: .mock, feed: .mock, onNavigation: { _ in })
    }
}
#Preview("Error") {
    NavigationStack {
        FeedView(source: .mock, feed: .mock(error: .emptyFeed), onNavigation: { _ in })
    }
}
