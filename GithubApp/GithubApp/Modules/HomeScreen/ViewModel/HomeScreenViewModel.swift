//
//  HomeScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject {
    
    @Published var repositoriesSelected = true
    @Published var usersSelected = false
    
    func didToggleRepositories() {
        repositoriesSelected.toggle()
    }
    
    func didToggleUsers() {
        usersSelected.toggle()
    }
}
