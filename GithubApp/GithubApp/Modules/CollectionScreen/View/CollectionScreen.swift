//
//  CollectionScreen.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import SwiftUI

struct CollectionScreen: View {
    
    @ObservedObject var viewModel: CollectionScreenViewModel
    
    init(viewModel: CollectionScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        renderContentView()
            .navigationTitle("Results for \"\(viewModel.searchQuery)\"")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() { viewModel.onAppear() }
    }
    
    func renderContentView() -> some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            } else {
                GeometryReader { geometry in
                    renderListView(geometry: geometry)
                }
            }
        }
    }
    func renderListView(geometry: GeometryProxy) -> some View {
        List {
            Section(
                content: {
                    ForEach(viewModel.repositories , id: \.self) { item in
                        RepositoryCellView(repository: item, geometry: geometry)
                    }
                },
                header: {
                    Text("\(viewModel.repositories.count) RESULTS")
                }
            )
        }
    }
}
