//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import About
import Foundation
import Testing

final class LibraryViewModelTests {
    @Test
    func testLoadedData() {
        let viewModel = LibraryViewModel()
        #expect(viewModel.libraries.count == 2)
    }
}
