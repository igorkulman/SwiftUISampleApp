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
    @State var sources: [RssSource]
    @State var selected: RssSource?
    @State private var showingAddSheet = false

    let onFinished: (RssSource) -> Void
    let settings: Settings

    public init(settings: Settings, onFinished: @escaping (RssSource) -> Void) {
        self.settings = settings
        self.onFinished = onFinished
        selected = settings.get()

        guard let jsonData = Bundle.module.loadFile(filename: "sources.json") else {
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

    public var body: some View {
        List(sources, id: \.rss) { source in
            SourceRow(source: source, isSelected: selected == source) {
                selected = source
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
                        guard let selected = selected else {
                            return
                        }

                        settings.set(selected)
                        onFinished(selected)
                    }.disabled(selected == nil)
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationStack {
                    AddSourceView { source in
                        showingAddSheet = false
                        if let source {
                            sources.append(source)
                        }
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        SetupView(settings: .mock(selected: nil), onFinished: { _ in })
    }
}
