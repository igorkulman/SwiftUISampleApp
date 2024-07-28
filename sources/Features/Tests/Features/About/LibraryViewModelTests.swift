//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import About
import Foundation
import XCTest

final class LibraryViewModelTests: XCTestCase {
    func testLoadedData() {
        let viewModel = LibraryViewModel()
        XCTAssertEqual(viewModel.libraries.count, 2)
    }
}
