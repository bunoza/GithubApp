//
//  UserListView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel: SearchResultsViewModel
    
    var body: some View {
        ZStack {
            if viewModel.areUsersLoading {
                LoaderView()
            } else {
                GeometryReader { geometry in
                    renderListView(geometry: geometry)
                }
            }
        }.onAppear() { viewModel.onUsersAppear() }
    }
    
    func renderListView(geometry: GeometryProxy) -> some View {
        List {
            ForEach(viewModel.users , id: \.self) { item in
                Section(
                    content: {
                        UserCellView(user: item, geometry: geometry, url: URL(string: item.htmlURL)!)
                    }
                )
            }
        }
    }
    
}
