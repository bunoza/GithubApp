//
//  RepositoryResponse.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//
import Foundation

// MARK: - RepositoryResponse
class GithubRepositoryResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [ReceivedRepository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
class ReceivedRepository: NSObject, Codable {
    let id: Int
    let name: String
    let owner: Owner
    let htmlURL: String?
    let itemDescription: String?
    let url: String
    let stargazersCount, watchersCount: Int
    let forksCount, openIssuesCount: Int
    let visibility: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlURL = "html_url"
        case itemDescription = "description"
        case url
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case visibility
    }
}

// MARK: - Owner
class Owner: NSObject, Codable {
        let login: String
        let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, receivedEventsURL: String
    let type: String
    let htmlURL, followersURL: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case receivedEventsURL = "received_events_url"
        case type
        case htmlURL = "html_url"
        case followersURL = "followers_url"
    }
}
