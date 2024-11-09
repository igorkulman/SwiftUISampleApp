//
//  File.swift
//  Features
//
//  Created by Igor Kulman on 09.11.2024.
//

import Core
import Foundation
import SwiftUI

@Observable
final class AddSourceViewModel {
    var title: String = ""
    var url: String = ""
    var rssUrl: String = ""
    var imageUrl: String = ""

    var isTitleValid: Bool {
        !title.isEmpty
    }

    var isUrlValid: Bool {
        !url.isEmpty && URL(string: url) != nil
    }

    var isRssUrlValid: Bool {
        !rssUrl.isEmpty && URL(string: rssUrl) != nil
    }

    var isValid: Bool {
        isTitleValid && isUrlValid && isRssUrlValid
    }

    private let onFinished: (RssSource?) -> Void

    init(onFinished: @escaping (RssSource?) -> Void) {
        self.onFinished = onFinished
    }

    func add() {
        guard let url = URL(string: url),
              let rssUrl = URL(string: rssUrl) else {
            return
        }

        onFinished(
            RssSource(
                title: title,
                url: url,
                rss: rssUrl,
                icon: imageUrl
            )
        )
    }

    func close() {
        onFinished(nil)
    }
}
