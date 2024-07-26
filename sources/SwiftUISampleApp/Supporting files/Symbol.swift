//
//  Symbol.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

enum Symbol: String {
    case info = "info.circle"
    case checkmark
    case rightChevron = "chevron.right"
}

extension Image {
    init(symbol: Symbol) {
        self.init(systemName: symbol.rawValue)
    }
}
