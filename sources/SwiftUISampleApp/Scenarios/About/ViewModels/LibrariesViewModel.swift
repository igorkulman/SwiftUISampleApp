//
//  LibrariesViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

final class LibraryViewModel {
    let libraries: [Library]

    init() {
        guard let path = Bundle.main.path(forResource: "Licenses", ofType: "plist"),
                let array = NSArray(contentsOfFile: path) as? [[String: Any]]
        else {
            fatalError("Invalid bundle linceses file")
        }

        libraries = array.compactMap { item -> Library? in
            guard let title = item["title"] as? String, let license = item["license"] as? String else {
                return nil
            }
            return Library(title: title, license: license)
        }
    }
}
