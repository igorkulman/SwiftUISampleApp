//
//  AboutViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

@Observable
final class AboutViewModel {
    enum NavigationTarget {
        case libraries
    }

    @ObservationIgnored let appName: String
    @ObservationIgnored let appVersion: String
    var showWebView = false

    private let onNavigation: (NavigationTarget) -> Void

    init(onNavigation: @escaping (NavigationTarget) -> Void) {
        self.onNavigation = onNavigation

        appName = Bundle.main.appName
        appVersion = "\(Bundle.main.appVersion) (\(Bundle.main.appBuild))"
    }

    func showLibraries() {
        onNavigation(.libraries)
    }

    func showBlog() {
        showWebView = true
    }
}
