//
//  AuthorDetailsViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 08.04.2022..
//

import Foundation

class AuthorDetailsViewModel {
    
    @Published var author: UsersResponse
    
    init(author: UsersResponse) {
        self.author = author
    }
    
    
    
}
