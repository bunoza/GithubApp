//
//  GithubRepository.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import Combine

protocol GithubRepository {
    func fetch(query: String) -> AnyPublisher<Result<GithubRepositoryResponse,NetworkError>,Never>
}
