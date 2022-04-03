//
//  GithubRepositoryImpl.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import Combine

class GithubRepositoryImpl: GithubRepository {
    func fetch(query: String) -> AnyPublisher<Result<GithubRepositoryResponse,NetworkError>,Never> {
        return RestManager.fetch(url: "https://api.github.com/search/repositories?q=\(query)")
    }
}
