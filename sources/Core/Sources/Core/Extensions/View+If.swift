//
//  File.swift
//  Core
//
//  Created by Igor Kulman on 09.11.2024.
//

import Foundation
import SwiftUI

public extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
