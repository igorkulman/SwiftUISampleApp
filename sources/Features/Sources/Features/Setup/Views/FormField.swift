//
//  File.swift
//  Features
//
//  Created by Igor Kulman on 09.11.2024.
//

import Foundation
import SwiftUI

struct FormField: View {
    enum FieldType {
        case string(required: Bool)
        case url(required: Bool)

        var isURL: Bool {
            switch self {
            case .url:
                return true
            case .string:
                return false
            }
        }

        func validate(text: String) -> Bool {
            switch self {
            case let .string(required):
                return !required || !text.isEmpty
            case let .url(required):
                return !required || text.isValidURL
            }
        }
    }

    let type: FieldType
    @Binding var text: String
    @State var isValid = true

    var body: some View {
        TextField("", text: $text, onEditingChanged: { isEditing in
            if isEditing {
                isValid = true
            } else {
                isValid = type.validate(text: text)
            }
        })
        .foregroundColor(isValid ? .primary : .red)
        .if(type.isURL) {
            $0.keyboardType(.URL)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }
}
