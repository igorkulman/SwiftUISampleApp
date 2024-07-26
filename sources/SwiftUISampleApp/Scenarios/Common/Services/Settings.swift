//
//  Settings.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

struct Settings {
    var get: () -> RssSource?
    var set: (RssSource?) -> Void
}

extension Settings {
    private static let key = "source"
    static var live: Self = Settings(
        get: {
            UserDefaults.standard.data(forKey: Self.key)
                .flatMap { try?  JSONDecoder().decode(RssSource.self, from: $0) }
        }, set: { source in
            guard let source else {
                UserDefaults.standard.removeObject(forKey: Self.key)
                return
            }
            UserDefaults.standard.set(try? JSONEncoder().encode(source), forKey: Self.key)
        })
}

#if DEBUG
extension Settings {
    static func mock(selected: RssSource?) -> Self {
        Settings(get: { selected }, set: { _ in })
    }
}
#endif
