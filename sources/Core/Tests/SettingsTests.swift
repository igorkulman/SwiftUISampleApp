//
//  File.swift
//  
//
//  Created by Igor Kulman on 28.07.2024.
//

@testable import Core
import Foundation
import Testing

@Suite(.serialized)
final class SettingsTests {
    init() {
        UserDefaults.standard.removeObject(forKey: "source")
    }

    @Test
    func testInitialGet() {
        let settings = Settings.live
        #expect(settings.get() == nil)
    }

    @Test
    func testSetAndGet() {
        let settings = Settings.live
        settings.set(.mock)
        #expect(settings.get() == .mock)
    }

    @Test
    func testRemoving() {
        let settings = Settings.live
        settings.set(.mock)
        settings.set(nil)
        #expect(settings.get() == nil)
    }
}
