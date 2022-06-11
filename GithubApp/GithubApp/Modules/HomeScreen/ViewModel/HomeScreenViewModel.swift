//
//  HomeScreenViewModel.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var showingSheet = false
    
    let persistence: UserDefaultsManager = UserDefaultsManager()
    
    @ViewBuilder
    func searchResultViewBuilder(text: String) -> some View {
        SearchResultsView(
            viewModel: SearchResultsViewModel(
                searchQuery: text
            )
        )
    }
    
    func queryIsEmpty(text: String) -> Bool {
        return text.isEmpty
    }
}
