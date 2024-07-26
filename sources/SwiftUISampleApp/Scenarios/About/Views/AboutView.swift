//
//  AboutView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SafariServices
import SwiftUI

struct AboutView: View {
    @State private var viewModel: AboutViewModel

    init(onNavigation: @escaping (AboutViewModel.NavigationTarget) -> Void) {
        viewModel = AboutViewModel(onNavigation: onNavigation)
    }

    var body: some View {
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
            AboutRow(title: NSLocalizedString("Used libraries", comment: "")) {
                viewModel.showLibraries()
            }
            AboutRow(title: NSLocalizedString("Author's blog", comment: "")) {
                viewModel.showBlog()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showWebView) {
            SafariWebView(url: URL(string: "https://blog.kulman.sk")!)
                .ignoresSafeArea()
        }
        .navigationTitle("About")
    }
}

#Preview {
    NavigationStack {
        AboutView(onNavigation: { _ in })
    }
}
