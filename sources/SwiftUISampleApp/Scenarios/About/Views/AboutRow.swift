//
//  AboutRow.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

struct AboutRow: View {
    let title: String
    let onTap: (() -> Void)?

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .expandTap {
                onTap?()
            }
    }
}
