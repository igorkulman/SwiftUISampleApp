//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Core
import Foundation
import XCTest

final class SettingsTests: XCTestCase {
    override func setUp() {
        super.setUp()

        UserDefaults.standard.removeObject(forKey: "source")
    }

    func testInitialGet() {
        let settings = Settings.live
        XCTAssertNil(settings.get())
    }

    func testSetAndGet() {
        let settings = Settings.live
        settings.set(.mock)
        XCTAssertEqual(settings.get(), .mock)
    }

    func testRemoving() {
        let settings = Settings.live
        settings.set(.mock)
        settings.set(nil)
        XCTAssertNil(settings.get())
    }
}
