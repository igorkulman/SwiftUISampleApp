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
    enum NavigationTarget {
        case libraries
    }

    @State private var viewModel: ViewModel

    init(onNavigation: @escaping (NavigationTarget) -> Void) {
        viewModel = ViewModel(onNavigation: onNavigation)
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

// MARK: View Model

extension AboutView {
    @Observable
    final class ViewModel {
        let appName: String
        let appVersion: String
        var showWebView = false

        private let onNavigation: (NavigationTarget) -> Void

        init(onNavigation: @escaping (NavigationTarget) -> Void) {
            self.onNavigation = onNavigation

            appName = Bundle.main.appName
            appVersion = "\(Bundle.main.appVersion) (\(Bundle.main.appBuild))"
        }

        func showLibraries() {
            onNavigation(.libraries)
        }

        func showBlog() {
            showWebView = true
        }
    }
}

// MARK: SFSafariViewController

extension AboutView {
    private struct SafariWebView: UIViewControllerRepresentable {
        let url: URL

        func makeUIViewController(context: Context) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }

        func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
    }
}

#Preview {
    NavigationStack {
        AboutView(onNavigation: { _ in })
    }
}
