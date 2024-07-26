//
//  SourceSelectionView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @State private var viewModel: SetupViewModel

    init(settings: Settings, onFinished: @escaping () -> Void) {
        viewModel = SetupViewModel(
            settings: settings,
            onFinished: onFinished
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

#Preview {
    NavigationStack {
        SetupView(settings: .mock(selected: nil), onFinished: {})
    }
}
