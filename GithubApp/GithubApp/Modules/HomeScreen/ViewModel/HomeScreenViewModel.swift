//
//  HomeScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject, HomeScreenViewModelDelegate {
    
    
    @Published var repositoriesSelected = true
    @Published var usersSelected = false
    @Published var text: String = ""
    @Published var showingSheet = false

    
    func didToggleRepositories() {
        repositoriesSelected.toggle()
    }
    
    func didToggleUsers() {
        usersSelected.toggle()
    }
    
    @ViewBuilder
    func searchResultViewBuilder(text: String) -> some View {
        SearchResultsView(
            viewModel: SearchResultsViewModel(
                usersSelected: usersSelected,
                repositoriesSelected: repositoriesSelected,
                githubRepository: GithubRepositoryImpl(),
                userRepository: UsersRepositoryImpl(),
                searchQuery: text
            )
        )
    }
    
//MARK: Delegate Implementation
    func queryIsEmpty(text: String) -> Bool {
        return text.isEmpty
    }
    
    func getRepositories() -> Bool {
        return repositoriesSelected
    }
    
    func getUsers() -> Bool {
        return usersSelected
    }
    
    func toggleRepositories() {
        repositoriesSelected.toggle()
    }
    
    func toggleUsers() {
        usersSelected.toggle()
    }
}

//MARK: Delegate
protocol HomeScreenViewModelDelegate {
    func getRepositories() -> Bool
    func getUsers() -> Bool
    func toggleRepositories()
    func toggleUsers()
}
