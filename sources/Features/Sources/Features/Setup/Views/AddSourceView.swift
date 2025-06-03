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
    @State var title: String = ""
    @State var url: String = ""
    @State var rssUrl: String = ""
    @State var imageUrl: String = ""

    let onFinished: (RssSource?) -> Void
    var isValid: Bool {
        !title.isEmpty && url.isValidURL && rssUrl.isValidURL && (imageUrl.isEmpty || imageUrl.isValidURL)
    }

    init(onFinished: @escaping (RssSource?) -> Void) {
        self.onFinished = onFinished
    }

    var body: some View {
        Form {
            Section(header: Text("Title", bundle: .module)) {
                FormField(type: .string(required: true), text: $title)
            }
            Section(header: Text("URL", bundle: .module)) {
                FormField(type: .url(required: true), text: $url)
            }
            Section(header: Text("RSS URL", bundle: .module)) {
                FormField(type: .url(required: true), text: $rssUrl)
            }
            Section(header: Text("Image URL (optional)", bundle: .module)) {
                FormField(type: .url(required: false), text: $imageUrl)
            }
        }.navigationBarTitle(Text("Add source", bundle: .module))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        onFinished(nil)
                    } label: {
                        Image(symbol: .close)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(NSLocalizedString("Add", bundle: .module, comment: "")) {
                        guard let url = URL(string: url),
                              let rssUrl = URL(string: rssUrl) else {
                            return
                        }

                        onFinished(RssSource(title: title, url: url, rss: rssUrl, icon: imageUrl))
                    }.disabled(!isValid)
                }
            }
    }
}

#Preview {
    NavigationStack {
        AddSourceView(onFinished: { print($0) })
    }
}
