//
//  CollectionScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import Combine

class CollectionScreenViewModel: ObservableObject {
    
    @Published var repositories: [ReceivedRepository] = []
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    
    let usersSelected: Bool
    let repositoriesSelected: Bool
    let searchQuery: String
    let githubRepository: GithubRepository
    var disposebag = Set<AnyCancellable>()
    
    init(usersSelected: Bool, repositoriesSelected: Bool, githubRepository: GithubRepository, searchQuery: String) {
        self.usersSelected = usersSelected
        self.repositoriesSelected = repositoriesSelected
        self.githubRepository = githubRepository
        self.searchQuery = searchQuery
    }
    
    func onAppear() {
        setupRepositoriesListener()
    }
    
    func setupRepositoriesListener() {
        isLoading = true
        
        githubRepository.fetch(query: searchQuery)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .tryMap({ result -> GithubRepositoryResponse in
                switch result {
                case .success(let result):
                    self.isLoading = false
                    return result
                case .failure(let error):
                    self.isLoading = false
                    throw error
                }
            })
            .map({ response -> [ReceivedRepository] in
                return response.items
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let error):
                    self.error = error
                }
            }, receiveValue: { receivedRepositories in
                self.repositories = receivedRepositories
            })
            .store(in: &disposebag)
    }
    
}
