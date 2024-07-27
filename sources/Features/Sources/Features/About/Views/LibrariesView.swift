//
//  LibrariesView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

public struct LibrariesView: View {
    private let viewModel = LibraryViewModel()

    public init() {}

    public var body: some View {
        List(viewModel.libraries, id: \.title) { library in
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
