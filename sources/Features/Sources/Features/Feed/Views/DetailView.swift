//
//  DetailView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

public struct DetailView: View {
    let item: RssItem

    public init(item: RssItem) {
        self.item = item
    }

    public var body: some View {
        WebView(url: item.link)
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
