//
//  UserListView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel: CollectionScreenViewModel
    
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
            Section(
                content: {
                    ForEach(viewModel.users , id: \.self) { item in
                        UserCellView(user: item, geometry: geometry, url: URL(string: "https://github.com/bun")!)
                    }
                },
                header: {
                    Text("\(viewModel.users.count) RESULTS")
                }
            )
        }
    }
    
}
