//
//  AboutView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SafariServices
import SwiftUI

public struct AboutView: View {
    public enum NavigationTarget {
        case libraries
    }

    @State private var viewModel: AboutViewModel

    public init(onNavigation: @escaping (NavigationTarget) -> Void) {
        viewModel = AboutViewModel(onNavigation: onNavigation)
    }

    public var body: some View {
        List {
            HStack(alignment: .center) {
                Spacer()
                VStack {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(16)
                    Text(viewModel.appName)
                        .font(.headline)
                    Text(viewModel.appVersion)
                        .font(.caption2)
                }
                Spacer()
            }
            AboutRow(title: NSLocalizedString("Used libraries", bundle: .module, comment: "")) {
                viewModel.showLibraries()
            }
            AboutRow(title: NSLocalizedString("Author's blog", bundle: .module, comment: "")) {
                viewModel.showBlog()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showWebView) {
            SafariWebView(url: URL(string: "https://blog.kulman.sk")!)
                .ignoresSafeArea()
        }
        .navigationTitle(Text("About", bundle: .module))
    }
}

#Preview {
    NavigationStack {
        AboutView(onNavigation: { _ in })
    }
}
