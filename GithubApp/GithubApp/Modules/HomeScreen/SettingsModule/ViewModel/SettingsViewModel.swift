//
//  SheetViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 20.04.2022..
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @State var savedSettings: GithubAppSaveModel
    
    let persistence: UserDefaultsManager = UserDefaultsManager()
    
    init() {
        switch persistence.getGithubSettings() {
        case .success(let saveModel):
            self.savedSettings = saveModel
        case .failure:
            self.savedSettings = GithubAppSaveModel(
                isUsersChecked: false,
                isRepositoriesChecked: true
            )
            break
        }
    }
    
    func toggleUsers() {
        savedSettings.isUsersChecked.toggle()
    }
    
    func toggleRepositories() {
        savedSettings.isRepositoriesChecked.toggle()
    }
    
    func saveSettings() {
        persistence.saveGithubSettings(saveModel: savedSettings)
        persistence.defaults.synchronize()
    }
}
