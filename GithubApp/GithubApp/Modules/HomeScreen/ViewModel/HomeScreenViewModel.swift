//
//  HomeScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var showingSheet = false
    
    let persistence: UserDefaultsManager = UserDefaultsManager()
    
    @ViewBuilder
    func searchResultViewBuilder(text: String) -> some View {
        let saveModel = persistence.getGithubSettings()
        switch saveModel {
        case .success(let currentSaveModel):
            SearchResultsView(
                viewModel: SearchResultsViewModel(
                    usersSelected: currentSaveModel.isUsersChecked,
                    repositoriesSelected: currentSaveModel.isRepositoriesChecked,
                    githubRepository: GithubRepositoryImpl(),
                    userRepository: UsersRepositoryImpl(),
                    searchQuery: text
                )
            )
        case .failure(let error):
            ErrorView(error: error)
        }
        
    }
    
    func queryIsEmpty(text: String) -> Bool {
        return text.isEmpty
    }
}
