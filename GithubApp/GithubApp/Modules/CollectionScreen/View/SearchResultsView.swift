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
    @State private var dragOffset = CGSize.zero
    
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
                .onAppear(
                    perform: {
                        viewModel.onUsersAppear()
                        viewModel.onRepositoriesAppear()
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
            } else {
                ErrorView(error: GithubAppError.tabNotPickedError)
            }
        }
    }
    
    func renderUsersRepositoriesUI() -> some View {
        VStack {
            if selectedTab == .Users {
                renderUsersUI()
            }
            if selectedTab == .Repositories {
                renderRepositoriesUI()
            }
        }
    }
    
    func renderUsersUI() -> some View {
        VStack {
            if viewModel.areUsersLoading {
                LoaderView()
            } else {
                renderPicker()
                UserListView(
                    viewModel: viewModel,
                    selectedTab: $selectedTab,
                    showPicker: viewModel.showPicker
                )
                .cornerRadius(8)
                .transition(.swapRight)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            dragOffset = CGSize(width: gesture.translation.width, height: 0)
                        }
                        .onEnded { gesture in
                            withAnimation {
                                dragOffset = .zero
                            }
                            if self.viewModel.isRightSwipeRecognized(gesture: gesture) {
                                selectedTab = .Repositories
                            }
                        }
                )
            }
        }
    }
    
    func renderRepositoriesUI() -> some View {
        VStack {
            if viewModel.areRepositoriesLoading {
                LoaderView()
            } else {
                renderPicker()
                RepositoryListView(
                    viewModel: viewModel,
                    selectedTab: $selectedTab,
                    showPicker: viewModel.showPicker
                )
                .cornerRadius(8)
                .transition(.swapLeft)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            dragOffset = CGSize(width: gesture.translation.width, height: 0)
                        }
                        .onEnded { gesture in
                            withAnimation {
                                dragOffset = .zero
                            }
                            if self.viewModel.isLeftSwipeRecognized(gesture: gesture) {
                                selectedTab = .Users
                            }
                        }
                )
            }
        }
    }
    
    func renderPicker() -> some View {
        VStack {
            VStack {
                Picker("Tabs", selection: $selectedTab) {
                    ForEach(Tabs.allCases) { tab in
                        Text(String(describing: tab))
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
    
}

