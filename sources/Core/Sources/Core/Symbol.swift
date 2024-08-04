//
//  Symbol.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

public enum Symbol: String {
    case info = "info.circle"
    case checkmark
    case rightChevron = "chevron.right"
    case gear
}

public extension Image {
    init(symbol: Symbol) {
        self.init(systemName: symbol.rawValue)
    }
}
