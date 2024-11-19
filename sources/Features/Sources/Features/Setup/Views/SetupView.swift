//
//  SourceSelectionView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Core
import Foundation
import SwiftUI

public struct SetupView: View {
    @State private var viewModel: SetupViewModel
    @State private var showingAddSheet = false

    public init(onFinished: @escaping (RssSource) -> Void) {
        viewModel = SetupViewModel(
            onFinished: onFinished
        )
    }

    public var body: some View {
        List(viewModel.sources, id: \.rss) { source in
            SourceRow(source: source, isSelected: viewModel.selected == source) {
                viewModel.select(source: source)
            }
        }.navigationTitle(Text("Select source", bundle: .module))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(symbol: .plus)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(NSLocalizedString("Next", bundle: .module, comment: "")) {
                        viewModel.onNext()
                    }.disabled(!viewModel.isValid)
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationStack {
                    AddSourceView { source in
                        showingAddSheet = false
                        if let source {
                            viewModel.add(source: source)
                        }
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        SetupView(onFinished: { _ in })
            .dependency(\.settings, .mock(selected: nil))
    }
}
