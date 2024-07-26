//
//  CoordinatorView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator: Coordinator

    init(container: Container) {
        _coordinator = StateObject(wrappedValue: Coordinator(container: container))
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: .setup)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
        }
    }
}
