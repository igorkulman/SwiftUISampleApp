//
//  DetailView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

struct DetailView: View {
    let item: RssItem

    var body: some View {
        WebView(url: item.link)
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
