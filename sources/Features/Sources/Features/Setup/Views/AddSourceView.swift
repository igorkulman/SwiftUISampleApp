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
                TextField("", text: $viewModel.title)
            }
            Section(header: Text("URL", bundle: .module)) {
                TextField("", text: $viewModel.url)
                    .keyboardType(.URL)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Section(header: Text("RSS URL", bundle: .module)) {
                TextField("", text: $viewModel.rssUrl)
                    .keyboardType(.URL)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Section(header: Text("Image URL (optional)", bundle: .module)) {
                TextField("", text: $viewModel.imageUrl)
                    .keyboardType(.URL)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
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
