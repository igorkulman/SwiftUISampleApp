//
//  Bundle+Extensions.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

extension Bundle {
    func loadFile(filename fileName: String) -> Data? {
        let parts = fileName.components(separatedBy: ".")
        if let url = url(forResource: parts[0], withExtension: parts[1]),
            let data = try? Data(contentsOf: url) {
            return data
        } else {
            return nil
        }
    }
}
