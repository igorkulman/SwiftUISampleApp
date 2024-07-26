//
//  Container.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Core
import Feed
import Foundation

public struct Container {
    var settings: Settings
    var feed: Feed
}

extension Container {
    public static var live: Self = Container(
        settings: .live,
        feed: .live
    )
}

#if DEBUG
extension Container {
    public static var mock: Self = Container(
        settings: .mock(selected: nil),
        feed: .mock
    )
}
#endif
