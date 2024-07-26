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

    @StateObject private var viewModel: ViewModel

    init(onNavigation: @escaping (NavigationTarget) -> Void) {
        _viewModel = StateObject(
            wrappedValue: ViewModel(onNavigation: onNavigation)
        )
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
            AboutRow(title: "Used libraries") {
                viewModel.showLibraries()
            }
            AboutRow(title: "Author's blog") {
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

extension AboutView {
    private class ViewModel: ObservableObject {
        let appName: String
        let appVersion: String
        @Published var showWebView = false

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
