//
//  ItemRow.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation
import SwiftUI

struct ItemRow: View {
    let item: RssItem
    let onTap: (() -> Void)?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                if let description = item.description {
                    Text(description)
                        .lineLimit(3)
                }
            }
            Spacer()
            Image(symbol: .rightChevron)
        }.expandTap {
            onTap?()
        }
    }
}

#Preview {
    ItemRow(item: .mock, onTap: nil)
}
