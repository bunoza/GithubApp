//
//  CollectionScreen.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import SwiftUI

struct SearchResultsView: View {
    
    @ObservedObject var viewModel: SearchResultsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedTab: Tabs = .Repositories
    
    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let error = viewModel.error {
            ErrorView(error: error)
        } else {
            renderContentView()
                .navigationTitle("Results for \"\(viewModel.searchQuery)\"")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(
                    content: {
                        ToolbarItem(placement: .navigationBarTrailing)
                        {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                    }
                )
        }
    }
    
    func renderContentView() -> some View {
        ZStack {
            let tabs = viewModel.initUI()
            if tabs.contains(.Users) && tabs.contains(.Repositories) {
                renderUsersRepositoriesUI()
            } else if tabs.contains(.Users) {
                renderUsersUI()
            } else if tabs.contains(.Repositories) {
                renderRepositoriesUI()
            }
        }
    }
    
    func renderUsersRepositoriesUI() -> some View {
        VStack {
            VStack {
                Picker("Tabs", selection: $selectedTab) {
                    ForEach(Tabs.allCases) { tab in
                        Text(String(describing: tab))
                    }
                }
            }
            .pickerStyle(.segmented)
            if selectedTab == .Users {
                renderUsersUI()
            }
            if selectedTab == .Repositories {
                renderRepositoriesUI()
            }
        }
    }
    
    func renderUsersUI() -> some View {
        UserListView(viewModel: viewModel)
            .onAppear(perform: { viewModel.onUsersAppear() })
    }
    
    func renderRepositoriesUI() -> some View {
        RepositoryListView(viewModel: viewModel)
            .onAppear(perform: { viewModel.onRepositoriesAppear() })
    }
}
