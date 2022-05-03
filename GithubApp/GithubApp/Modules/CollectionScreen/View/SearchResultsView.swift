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
                .navigationBarBackButtonHidden(true)
                .toolbar(
                    content: {
                        ToolbarItem(placement: .navigationBarLeading)
                        {
                            Button(
                                action: {
                                    dismiss()
                                }
                            )
                            {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                )
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
                .onAppear(perform: {
                    viewModel.onUsersAppear()
                    viewModel.onRepositoriesAppear()
                })
        }
    }
    
    func renderContentView() -> some View {
        ZStack {
            let tabs = viewModel.initUI()
            if tabs.contains(.Users) && tabs.contains(.Repositories) {
                renderUsersRepositoriesUI()
                    .animation( Animation.easeInOut(duration: 0.35), value: selectedTab)
            } else if tabs.contains(.Users) {
                renderUsersUI()
            } else if tabs.contains(.Repositories) {
                renderRepositoriesUI()
            }
        }
    }
    
    func renderUsersRepositoriesUI() -> some View {
        VStack {
            if selectedTab == .Users {
                renderUsersUI()
                    .transition(.swapRight)
            }
            if selectedTab == .Repositories {
                renderRepositoriesUI()
                    .transition(.swapLeft)
            }
        }
    }
    
    func renderUsersUI() -> some View {
        ZStack {
            if viewModel.areUsersLoading {
                LoaderView()
            } else {
                UserListView(viewModel: viewModel, selectedTab: $selectedTab, showPicker: viewModel.showPicker)
            }
        }
    }
    
    func renderRepositoriesUI() -> some View {
        ZStack {
            if viewModel.areRepositoriesLoading {
                LoaderView()
            } else {
                RepositoryListView(viewModel: viewModel, selectedTab: $selectedTab, showPicker: viewModel.showPicker)
            }
        }
    }
}

