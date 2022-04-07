//
//  CollectionScreen.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import SwiftUI

struct CollectionScreen: View {
    
    @ObservedObject var viewModel: CollectionScreenViewModel
    
    init(viewModel: CollectionScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        renderContentView()
            .navigationTitle("Results for \"\(viewModel.searchQuery)\"")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func renderContentView() -> some View {
        ZStack {
            if viewModel.repositoriesSelected && viewModel.usersSelected {
                TabView {
                    RepositoryListView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "list.bullet.rectangle")
                            Text("Repositories")
                        }
                    UserListView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "person.circle")
                            Text("Users")
                        }
                }

            } else if viewModel.usersSelected {
                UserListView(viewModel: viewModel)
            } else {
                RepositoryListView(viewModel: viewModel)
            }
        }
    }
    
}
