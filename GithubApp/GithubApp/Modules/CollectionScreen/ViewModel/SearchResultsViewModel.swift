//
//  CollectionScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI
import Combine

class SearchResultsViewModel: ObservableObject {
    
    @Published var repositories: [ReceivedRepository] = []
    @Published var users: [User] = []
    @Published var error: Error?
    @Published var areUsersLoading: Bool = false
    @Published var areRepositoriesLoading: Bool = false
    
    let persistence: UserDefaultsManager = UserDefaultsManager()
    let searchQuery: String
    let githubRepository: GithubRepository = GithubRepositoryImpl()
    let userRepository: UsersRepository = UsersRepositoryImpl()
    var disposebag = Set<AnyCancellable>()
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
    }
    
    func onRepositoriesAppear() {
        setupRepositoriesListener()
    }
    
    func onUsersAppear() {
        setupUsersListener()
    }
    
    @ViewBuilder
    func initUI() -> some View {
        let saveModel = persistence.getGithubSettings()
        switch saveModel {
        case .success(let currentSaveModel):
            if currentSaveModel.isUsersChecked && currentSaveModel.isRepositoriesChecked {
                renderUsersRepositoriesUI()
            } else if currentSaveModel.isUsersChecked {
                renderUsersUI()
            } else {
                renderRepositoriesUI()
            }
        case .failure(let error):
            ErrorView(error: error)
        }
    }
    
    @ViewBuilder
    func renderUsersUI() -> some View {
        UserListView(viewModel: self)
            .onAppear(perform: { self.onUsersAppear() })
    }
    
    @ViewBuilder
    func renderRepositoriesUI() -> some View {
        RepositoryListView(viewModel: self)
            .onAppear(perform: { self.onRepositoriesAppear() })
    }
    
    @ViewBuilder
    func renderUsersRepositoriesUI() -> some View {
        TabView {
            renderRepositoriesUI()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Repositories")
                }
            renderUsersUI()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Users")
                }
        }
    }
    
    func setupRepositoriesListener() {
        areRepositoriesLoading = true
        
        githubRepository.fetch(query: searchQuery)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .tryMap({ result -> GithubRepositoryResponse in
                switch result {
                case .success(let result):
                    self.areRepositoriesLoading = false
                    return result
                case .failure(let error):
                    self.areRepositoriesLoading = false
                    throw error
                }
            })
            .map({ response -> [ReceivedRepository] in
                return response.items
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.areRepositoriesLoading = false
                    break
                case .failure(let error):
                    self.error = error
                }
            }, receiveValue: { receivedRepositories in
                self.repositories = receivedRepositories
            })
            .store(in: &disposebag)
    }
    
    func setupUsersListener() {
        areUsersLoading = true
        
        userRepository.fetch(query: searchQuery)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .tryMap({ result -> UsersResponse in
                switch result {
                case .success(let result):
                    self.areUsersLoading = false
                    return result
                case .failure(let error):
                    self.areUsersLoading = false
                    throw error
                }
            })
            .map({ response -> [User] in
                return response.items
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.areUsersLoading = false
                    break
                case .failure(let error):
                    self.error = error
                }
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &disposebag)
    }
    
}
