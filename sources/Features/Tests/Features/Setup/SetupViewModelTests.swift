//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Setup
import Foundation
import Testing

final class SetupViewModelTests {
    @Test
    func testLoadedData() {
        let viewModel = SetupViewModel(settings: .mock(selected: nil), onFinished: { _ in })
        #expect(!viewModel.sources.isEmpty)
    }

    @Test
    func testSelectingASource() {
        let viewModel = SetupViewModel(settings: .mock(selected: nil), onFinished: { _ in })
        #expect(!viewModel.isValid)

        viewModel.select(source: .mock)
        #expect(viewModel.isValid)
    }

    @Test
    func testNavigation() {
        var finished: Bool = false
        let viewModel = SetupViewModel(settings: .mock(selected: nil)) { _ in
            finished = true
        }
        #expect(!finished)

        viewModel.select(source: .mock)
        viewModel.onNext()
        #expect(finished)
    }
}
