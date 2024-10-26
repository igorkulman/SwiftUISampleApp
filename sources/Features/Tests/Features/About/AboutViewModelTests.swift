//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import About
import Foundation
import Testing

final class AboutViewModelTests {
    @Test
    func testNavigation() {
        var target: AboutView.NavigationTarget?
        let viewModel = AboutViewModel {
            target = $0
        }
        #expect(target == nil)
        viewModel.showLibraries()
        #expect(target == .libraries)

        #expect(!viewModel.showWebView)
        viewModel.showBlog()
        #expect(viewModel.showWebView)
    }
}
