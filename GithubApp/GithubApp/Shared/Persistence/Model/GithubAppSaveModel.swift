//
//  GithubAppSaveModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 20.04.2022..
//

import Foundation

class GithubAppSaveModel: NSObject, Codable {
    var isUsersChecked: Bool
    var isRepositoriesChecked: Bool
    
    init(isUsersChecked: Bool, isRepositoriesChecked: Bool) {
        self.isUsersChecked = isUsersChecked
        self.isRepositoriesChecked = isRepositoriesChecked
    }
}
