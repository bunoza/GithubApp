//
//  UserDefaults.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 20.04.2022..
//

import Foundation

extension UserDefaults {
    @objc var githubAppSaveModel: GithubAppSaveModel {
        get {
            let decoder = JSONDecoder()
            var defaultSettings = GithubAppSaveModel(
                isUsersChecked: false,
                isRepositoriesChecked: true
            )
            do {
                guard let decoded = data(forKey: "saveModel")
                else {
                    return defaultSettings
                }
                defaultSettings = try decoder.decode(GithubAppSaveModel.self, from: decoded)
                
            }
            catch {
                return defaultSettings
            }
            return defaultSettings

        }
    }
}
