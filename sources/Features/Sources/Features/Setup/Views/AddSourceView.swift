//
//  File.swift
//  Features
//
//  Created by Igor Kulman on 09.11.2024.
//

import Core
import Foundation
import SwiftUI

struct AddSourceView: View {
    @State private var viewModel: AddSourceViewModel

    init(onFinished: @escaping (RssSource?) -> Void) {
        viewModel = AddSourceViewModel(
            onFinished: onFinished
        )
    }

    var body: some View {
        Form {
            Section(header: Text("Title", bundle: .module)) {
                FormField(type: .string(required: true), text: $viewModel.title)
            }
            Section(header: Text("URL", bundle: .module)) {
                FormField(type: .url(required: true), text: $viewModel.url)
            }
            Section(header: Text("RSS URL", bundle: .module)) {
                FormField(type: .url(required: true), text: $viewModel.rssUrl)
            }
            Section(header: Text("Image URL (optional)", bundle: .module)) {
                FormField(type: .url(required: false), text: $viewModel.imageUrl)
            }
        }.navigationBarTitle(Text("Add source", bundle: .module))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.close()
                    } label: {
                        Image(symbol: .close)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(NSLocalizedString("Add", bundle: .module, comment: "")) {
                        viewModel.add()
                    }.disabled(!viewModel.isValid)
                }
            }
    }
}

#Preview {
    NavigationStack {
        AddSourceView(onFinished: { print($0) })
    }
}
