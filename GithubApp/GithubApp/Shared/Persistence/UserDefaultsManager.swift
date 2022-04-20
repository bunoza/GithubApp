//
//  UserDefaultsManager.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 20.04.2022..
//

import Foundation
import Combine

class UserDefaultsManager {
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()

    func saveGithubSettings(isUsersChecked: Bool, isRepositoriesChecked: Bool) {
        let githubSaveModel = GithubAppSaveModel(
            isUsersChecked: isUsersChecked,
            isRepositoriesChecked: isRepositoriesChecked
        )
        do {
            let data = try encoder.encode(githubSaveModel)
            defaults.set(data, forKey: "saveModel")
        }
        catch{}
    }
    
    func getGithubSettings() -> GithubAppSaveModel {
        let saveModel = defaults.githubAppSaveModel
        return saveModel
    }
    
}
