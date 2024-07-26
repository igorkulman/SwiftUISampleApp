//
//  SwiftUISampleAppApp.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

import SwiftUI

@main
struct SwiftUISampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView(container: .live)
        }
    }
}
