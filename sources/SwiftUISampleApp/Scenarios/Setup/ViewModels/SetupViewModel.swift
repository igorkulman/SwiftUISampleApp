//
//  SetupViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

@Observable
final class SetupViewModel {
    private(set) var sources: [RssSource]
    private(set) var selected: RssSource?

    var isValid: Bool {
        selected != nil
    }

    private let settings: Settings
    private let onFinished: () -> Void

    init(settings: Settings, onFinished: @escaping () -> Void) {
        self.settings = settings
        self.onFinished = onFinished

        guard let jsonData = Bundle.main.loadFile(filename: "sources.json") else {
            fatalError()
        }

        do {
            let decoder = JSONDecoder()
            let all = try decoder.decode(Array<RssSource>.self, from: jsonData)
            sources = all
        } catch {
            fatalError()
        }
    }

    func select(source: RssSource) {
        selected = source
    }

    func onNext() {
        settings.set(selected)
        onFinished()
    }
}
