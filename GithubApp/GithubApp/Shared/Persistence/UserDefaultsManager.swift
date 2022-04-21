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
    let decoder = JSONDecoder()
    
    func saveGithubSettings(saveModel: GithubAppSaveModel) {
        do {
            let data = try encoder.encode(saveModel)
            defaults.set(data, forKey: "saveModel")
        }
        catch{}
    }
    
    func getGithubSettings() -> Result<GithubAppSaveModel, GithubAppError> {
        var defaultSettings = GithubAppSaveModel(
            isUsersChecked: false,
            isRepositoriesChecked: true
        )
        do {
            guard let decoded = defaults.data(forKey: "saveModel")
            else {
                return .failure(.persistenceError)
            }
            defaultSettings = try decoder.decode(GithubAppSaveModel.self, from: decoded)
        }
        catch {
            return .failure(.error)
        }
        return .success(defaultSettings)
    }
    
}
