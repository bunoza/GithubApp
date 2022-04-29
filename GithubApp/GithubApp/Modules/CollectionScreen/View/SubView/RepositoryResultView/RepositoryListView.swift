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
    
    @Binding var selectedTab: Tabs
    
    let showPicker: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                renderListView(geometry: geometry)
            }
        }
        .onAppear() { viewModel.onRepositoriesAppear() }
    }
    
    func renderListView(geometry: GeometryProxy) -> some View {
        List {
            if showPicker {
                Section(
                    content: {
                        renderPicker()
                    }
                )
            }
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
    
    func renderPicker() -> some View {
        VStack {
            VStack {
                Picker("Tabs", selection: $selectedTab) {
                    ForEach(Tabs.allCases) { tab in
                        Text(String(describing: tab))
                    }
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
}
