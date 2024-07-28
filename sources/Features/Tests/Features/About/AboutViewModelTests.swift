//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import About
import Foundation
import XCTest

final class AboutViewModelTests: XCTestCase {
    func testNavigation() {
        var target: AboutView.NavigationTarget?
        let viewModel = AboutViewModel {
            target = $0
        }
        XCTAssertNil(target)
        viewModel.showLibraries()
        XCTAssertEqual(target, .libraries)

        XCTAssertFalse(viewModel.showWebView)
        viewModel.showBlog()
        XCTAssertTrue(viewModel.showWebView)
    }
}
