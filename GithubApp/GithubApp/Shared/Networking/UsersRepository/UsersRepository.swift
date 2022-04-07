//
//  UsersRepository.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import Combine

protocol UsersRepository {
    func fetch(query: String) -> AnyPublisher<Result<UsersResponse,NetworkError>,Never>
}
