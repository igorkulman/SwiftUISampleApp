//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Setup
import Core
import Foundation
import Testing

@Suite(.serialized)
final class SetupViewModelTests {
    init() {
        DependencyValues[\.settings] = .mock(selected: nil)
    }

    @Test
    func testLoadedData() {
        let viewModel = SetupViewModel(onFinished: { _ in })
        #expect(!viewModel.sources.isEmpty)
    }

    @Test
    func testSelectingASource() {
        let viewModel = SetupViewModel(onFinished: { _ in })
        #expect(!viewModel.isValid)

        viewModel.select(source: .mock)
        #expect(viewModel.isValid)
    }

    @Test
    func testNavigation() {
        var finished: Bool = false
        let viewModel = SetupViewModel() { _ in
            finished = true
        }
        #expect(!finished)

        viewModel.select(source: .mock)
        viewModel.onNext()
        #expect(finished)
    }
}
