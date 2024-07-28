//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Setup
import Foundation
import XCTest

final class SetupViewModelTests: XCTestCase {
    func testLoadedData() {
        let viewModel = SetupViewModel(settings: .mock(selected: nil), onFinished: {})
        XCTAssertFalse(viewModel.sources.isEmpty)
    }

    func testSelectingASource() {
        let viewModel = SetupViewModel(settings: .mock(selected: nil), onFinished: {})
        XCTAssertFalse(viewModel.isValid)

        viewModel.select(source: .mock)
        XCTAssertTrue(viewModel.isValid)
    }

    func testNavigation() {
        var finished: Bool = false
        let viewModel = SetupViewModel(settings: .mock(selected: nil)) {
            finished = true
        }
        XCTAssertFalse(finished)

        viewModel.select(source: .mock)
        viewModel.onNext()
        XCTAssertTrue(finished)
    }
}
