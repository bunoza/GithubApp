//
//  CollectionScreen.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import SwiftUI

struct SearchResultsView: View {
    
    @ObservedObject var viewModel: SearchResultsViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let error = viewModel.error {
            ErrorView(error: error)
        } else {
            renderContentView()
                .navigationTitle("Results for \"\(viewModel.searchQuery)\"")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(
                    content: {
                        ToolbarItem(placement: .navigationBarTrailing)
                        {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                    }
                )
        }
    }
    
    func renderContentView() -> some View {
        viewModel.initUI()
    }
}
