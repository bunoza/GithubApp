//
//  SheetViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 20.04.2022..
//

import Foundation
import SwiftUI

class SheetViewModel {
    
    let delegate: HomeScreenViewModelDelegate
    let persistence: UserDefaultsManager = UserDefaultsManager()
    
    @Published var savedSettings: GithubAppSaveModel
    
    init(delegate: HomeScreenViewModelDelegate) {
        self.delegate = delegate
        self.savedSettings = GithubAppSaveModel(isUsersChecked: false, isRepositoriesChecked: false)
    }
    
    func onAppear() {
        savedSettings = persistence.getGithubSettings()
    }
}
