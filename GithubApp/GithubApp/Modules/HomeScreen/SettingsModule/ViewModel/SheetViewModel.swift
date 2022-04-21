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
    
    init(delegate: HomeScreenViewModelDelegate) {
        self.delegate = delegate
    }
    
    func toggleUsers() {
        delegate.toggleUsers()
    }
    
    func toggleRepositories() {
        delegate.toggleRepositories()
    }
}
