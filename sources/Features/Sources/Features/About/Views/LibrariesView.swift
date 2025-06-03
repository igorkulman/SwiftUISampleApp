//
//  LibrariesView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

public struct LibrariesView: View {
    @State var libraries: [Library]

    public init() {
        guard let path = Bundle.module.path(forResource: "Licenses", ofType: "plist"),
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

    public var body: some View {
        List(libraries, id: \.title) { library in
            VStack(alignment: .leading) {
                Text(library.title)
                Text(library.license)
                    .font(.caption2)
            }
        }.navigationTitle(Text("Used libraries", bundle: .module))
    }
}

#Preview {
    NavigationStack {
        LibrariesView()
    }
}
