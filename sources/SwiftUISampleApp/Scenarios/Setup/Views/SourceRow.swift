//
//  SourceRow.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import Foundation
import SwiftUI

struct SourceRow: View {
    let source: RssSource
    let isSelected: Bool
    let onTap: (() -> Void)?

    var body: some View {
        HStack {
            AsyncImage(url: source.icon.flatMap({ URL(string: $0) })) {
                $0.image?.resizable().aspectRatio(contentMode: .fit)
            }.frame(width: 36, height: 36)
            Text(source.title)
            Spacer()
            if isSelected {
                Image(symbol: .checkmark)
            }
        }.expandTap {
            onTap?()
        }
    }
}

#Preview("Not selected")  {
    SourceRow(
        source: .mock,
        isSelected: false,
        onTap: nil
    )
}

#Preview("Selected") {
    SourceRow(
        source: .mock,
        isSelected: true,
        onTap: nil
    )
}
