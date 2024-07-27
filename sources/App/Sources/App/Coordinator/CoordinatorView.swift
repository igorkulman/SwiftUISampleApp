//
//  CoordinatorView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

public struct CoordinatorView: View {
    @State private var coordinator: Coordinator

    public init(container: Container) {
        coordinator = Coordinator(container: container)
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: .setup)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
        }
    }
}
