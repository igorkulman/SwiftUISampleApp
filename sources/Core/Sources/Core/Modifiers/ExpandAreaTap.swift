//
//  ExpandAreaTap.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

private struct ExpandAreaTap: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
            content
        }
    }
}

public extension View {
    func expandTap(tap: @escaping () -> Void) -> some View {
        self.modifier(ExpandAreaTap()).onTapGesture(perform: tap)
    }
}
