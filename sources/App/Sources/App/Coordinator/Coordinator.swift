//
//  Coordinator.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import About
import Core
import Foundation
import OSLog
import Feed
import Setup
import SwiftUI

@Observable
final class Coordinator {
    var path = NavigationPath()

    private let container: Container

    init(container: Container) {
        self.container = container

        Logger.appFlow.debug("Starting the coordinator")

        if let source = container.settings.get() {
            Logger.appFlow.info("RSS source already selected, starting with feed")
            showFeed(source: source)
        }
    }

    private func push(screen: Screen) {
        path.append(screen)
    }

    private func pop() {
        path.removeLast()
    }

    private func showFeed(source: RssSource) {
        Logger.appFlow.debug("Showing feed")
        push(screen: .feed(source))
    }

    private func showDetail(item: RssItem) {
        Logger.appFlow.debug("Showing item detail [title: \(item.title)]")
        push(screen: .item(item))
    }

    private func showAbout() {
        Logger.appFlow.debug("Showing about")
        push(screen: .about)
    }

    private func showLibraries() {
        Logger.appFlow.debug("Showing used libraries")
        push(screen: .libraries)
    }

    private func showSettings() {
        Logger.appFlow.debug("Showing settings")
        pop()
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .setup:
            SetupView(settings: container.settings) { [unowned self] source in
                showFeed(source: source)
            }
        case let .feed(source):
            FeedView(source: source, feed: container.feed) { [unowned self] target in
                switch target {
                case let .item(item):
                    showDetail(item: item)
                case .about:
                    showAbout()
                case .settings:
                    showSettings()
                }
            }
        case let .item(item):
            DetailView(item: item)
        case .about:
            AboutView {  [unowned self] target in
                switch target {
                case .libraries:
                    showLibraries()
                }
            }
        case .libraries:
            LibrariesView()
        }
    }
}
