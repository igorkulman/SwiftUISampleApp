//
//  SourceSelectionView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @StateObject private var viewModel: ViewModel

    init(settings: Settings, onFinished: @escaping () -> Void) {
        _viewModel = StateObject(
            wrappedValue: ViewModel(
                settings: settings,
                onFinished: onFinished
            )
        )
    }

    var body: some View {
        List(viewModel.sources, id: \.rss) { source in
            SourceRow(source: source, isSelected: viewModel.selected == source) {
                viewModel.select(source: source)
            }
        }.navigationTitle("Select source")
            .toolbar {
                ToolbarItem {
                    Button("Next") {
                        viewModel.onNext()
                    }.disabled(!viewModel.isValid)
                }
            }
    }
}

// MARK: View Model

extension SetupView {
    private class ViewModel: ObservableObject {
        @Published var sources: [RssSource]
        @Published var selected: RssSource?

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
}

#Preview {
    NavigationStack {
        SetupView(settings: .mock(selected: nil), onFinished: {})
    }
}
