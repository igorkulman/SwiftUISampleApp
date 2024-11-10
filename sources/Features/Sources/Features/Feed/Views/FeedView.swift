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

    @State private var viewModel: FeedViewModel

    public init(
        source: RssSource,
        feed: Feed,
        onNavigation: @escaping (NavigationTarget) -> Void
    ) {
        viewModel = FeedViewModel(
            source: source,
            feed: feed,
            onNavigation: onNavigation
        )
    }

    public var body: some View {
        LoadableScreen($viewModel.state) { data in
            List(data, id: \.title) { item in
                ItemRow(item: item) {
                    viewModel.showDetail(item: item)
                }
            }.refreshable {
                await viewModel.load()
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.load()
        }.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.showSettings()
                } label: {
                    Image(symbol: .gear)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.showAbout()
                } label: {
                    Image(symbol: .info)
                }
            }
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
