//
//  RepositoryListView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import SwiftUI

struct RepositoryListView: View {
    
    @ObservedObject var viewModel: SearchResultsViewModel
    
    var body: some View {
        ZStack {
            if viewModel.areRepositoriesLoading {
                LoaderView()
            } else {
                GeometryReader { geometry in
                    renderListView(geometry: geometry)
                }
            }
        }
        .onAppear() { viewModel.onRepositoriesAppear() }
    }
    
    func renderListView(geometry: GeometryProxy) -> some View {
        List {
            ForEach(viewModel.repositories , id: \.self) { item in
                Section(
                    content: {
                        if let url = item.htmlURL {
                            if let repoLink = URL(string: url) {
                                RepositoryCellView(repository: item, geometry: geometry, url: repoLink)
                            } else {
                                if let validURL = URL(string: RestEndpoints.error.endpoint()) {
                                    RepositoryCellView(repository: item, geometry: geometry, url: validURL)
                                }
                            }
                        }
                    }
                )
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
}
