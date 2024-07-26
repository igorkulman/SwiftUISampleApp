//
//  Coordinator.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import OSLog
import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    private let container: Container

    init(container: Container) {
        self.container = container

        Logger.appFlow.debug("Starting the coordinator")

        if container.settings.get() != nil {
            Logger.appFlow.info("RSS source already selected, starting with feed")
            showFeed()
        }
    }

    private func push(screen: Screen) {
        path.append(screen)
    }

    private func showFeed() {
        Logger.appFlow.debug("Showing feed")
        push(screen: .feed)
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

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .setup:
            SetupView(settings: container.settings) { [unowned self] in
                showFeed()
            }
        case .feed:
            FeedView(settings: container.settings, feed: container.feed) { [unowned self] target in
                switch target {
                case let .item(item):
                    showDetail(item: item)
                case .about:
                    showAbout()
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
