//
//  LoadableScreen.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SwiftUI

public enum ScreenState<T> {
    case loading
    case loaded(data: T)
    case error(data: T?, error: Error)

    public var error: Error? {
        switch self {
        case .loading, .loaded:
            return nil
        case let .error(data: _, error: error):
            return error
        }
    }

    public mutating func toError(error: Error) {
        switch self {
        case .loading:
            self = .error(data: nil, error: error)
        case let .loaded(data: data):
            self = .error(data: data, error: error)
        case .error:
            fatalError("Invalid transition")
        }
    }

    public mutating func toData() {
        switch self {
        case let .error(data: data, error: _):
            if let data {
                self = .loaded(data: data)
            }
        case .loading, .loaded:
            fatalError("Invalid transition")
        }
    }
}

public struct LoadableScreen<Content: View, T>: View {
    let state: Binding<ScreenState<T>>
    let content: (T) -> Content

    public init(_ state: Binding<ScreenState<T>>, @ViewBuilder onLoaded content: @escaping (T) -> Content) {
        self.state = state
        self.content = content
    }

    public var body: some View {
        ZStack {
            switch state.wrappedValue {
            case let .error(data: data, error: _):
                if let data {
                    content(data)
                }
            case let .loaded(data: data):
                content(data)
            case .loading:
                ProgressView()
            }
        }.errorAlert(state: state)
    }
}
