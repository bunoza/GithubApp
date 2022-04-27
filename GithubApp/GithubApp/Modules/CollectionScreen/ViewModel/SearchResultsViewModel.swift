//
//  CollectionScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI
import Combine

enum Tabs: CaseIterable, Identifiable {
    var id: Self { self }
    
    case Repositories
    case Users
}

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
    
    func initUI() -> [Tabs] {
        let saveModel = persistence.getGithubSettings()
        switch saveModel {
        case .success(let currentSaveModel):
            var resultsBool: [Tabs] = []
            if currentSaveModel.isRepositoriesChecked {
                resultsBool.append(.Repositories)
            }
            if currentSaveModel.isUsersChecked {
                resultsBool.append(.Users)
            }
            return resultsBool
        case .failure(let error):
            self.error = error
            return []
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
