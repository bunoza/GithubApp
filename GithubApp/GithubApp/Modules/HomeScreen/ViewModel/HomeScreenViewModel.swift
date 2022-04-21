//
//  HomeScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject, HomeScreenViewModelDelegate {
    
    @Published var text: String = ""
    @Published var showingSheet = false
    @Published var savedSettings: GithubAppSaveModel
    
    let persistence: UserDefaultsManager = UserDefaultsManager()
    
    init() {
        savedSettings = GithubAppSaveModel(
            isUsersChecked: false,
            isRepositoriesChecked: true
        )
    }
    
    @ViewBuilder
    func searchResultViewBuilder(text: String) -> some View {
        SearchResultsView(
            viewModel: SearchResultsViewModel(
                usersSelected: savedSettings.isUsersChecked,
                repositoriesSelected: savedSettings.isRepositoriesChecked,
                githubRepository: GithubRepositoryImpl(),
                userRepository: UsersRepositoryImpl(),
                searchQuery: text
            )
        )
    }
    
    func onAppear() {
        do {
            try savedSettings = persistence.getGithubSettings().get()
        }
        catch {}
    }
    
    //MARK: Delegate Implementation
    func queryIsEmpty(text: String) -> Bool {
        return text.isEmpty
    }
    
    func getRepositories() -> Bool {
        return savedSettings.isRepositoriesChecked
    }
    
    func getUsers() -> Bool {
        return savedSettings.isUsersChecked
    }
    
    func toggleRepositories() {
        savedSettings.isRepositoriesChecked.toggle()
        persistence.saveGithubSettings(saveModel: savedSettings)
    }
    
    func toggleUsers() {
        savedSettings.isUsersChecked.toggle()
        persistence.saveGithubSettings(saveModel: savedSettings)
    }
}

//MARK: Delegate
protocol HomeScreenViewModelDelegate {
    func getRepositories() -> Bool
    func getUsers() -> Bool
    func toggleRepositories()
    func toggleUsers()
}
