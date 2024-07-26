//
//  DetailView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI
import WebKit

struct DetailView: View {
    let item: RssItem

    var body: some View {
        WebView(url: item.link)
            .ignoresSafeArea()
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension DetailView {
    private struct WebView: UIViewRepresentable {
        let url: URL

        func makeUIView(context: Context) -> WKWebView {
            return WKWebView()
        }

        func updateUIView(_ webView: WKWebView, context: Context) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
