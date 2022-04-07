//
//  UsersRepositoryImpl.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import Combine

class UsersRepositoryImpl: UsersRepository {
    func fetch(query: String) -> AnyPublisher<Result<UsersResponse,NetworkError>,Never> {
        return RestManager.fetch(url: "https://api.github.com/search/users?q=\(query)")
    }
}
