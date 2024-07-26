//
//  Container.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

struct Container {
    var settings: Settings
    var feed: Feed
}

extension Container {
    static var live: Self = Container(
        settings: .live,
        feed: .live
    )
}

#if DEBUG
extension Container {
    static var mock: Self = Container(
        settings: .mock(selected: nil),
        feed: .mock
    )
}
#endif
