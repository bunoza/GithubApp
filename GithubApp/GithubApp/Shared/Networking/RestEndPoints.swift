//
//  RestEndPoints.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 13.04.2022..
//

import Foundation

public enum RestEndpoints {
    
    case repository(query: String)
    case user(query: String)
    case usersRepositories(query: String)
    case error
    
    static let githubBaseURL = Bundle.main.object(forInfoDictionaryKey: "GITHUB_BASE_URL") as! String
    static let usersAddon = Bundle.main.object(forInfoDictionaryKey: "USERS_ADDON") as! String
    static let githubErrorURL = Bundle.main.object(forInfoDictionaryKey: "GITHUB_ERROR_URL") as! String
    static let repositoriesAddon = Bundle.main.object(forInfoDictionaryKey: "REPOSITORIES_ADDON") as! String
    static let usersRepositoriesAddon = Bundle.main.object(forInfoDictionaryKey: "GITHUB_USERS_REPOSITORIES_ADDON") as! String
    
    public func endpoint() -> String {
        switch self {
        case .repository(let name):
            return RestEndpoints.githubBaseURL +
            RestEndpoints.repositoriesAddon +
            name
        case .user(let name):
            return RestEndpoints.githubBaseURL +
            RestEndpoints.usersAddon +
            name
        case .usersRepositories(let name):
            return RestEndpoints.githubBaseURL +
            RestEndpoints.usersAddon +
            name +
            RestEndpoints.usersRepositoriesAddon
        case .error:
            return RestEndpoints.githubErrorURL
        }
    }
}
