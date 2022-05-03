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
    
    @Binding var selectedTab: Tabs
    
    let showPicker: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                renderListView(geometry: geometry)
            }
        }
        .onAppear() { viewModel.onUsersAppear() }
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
            ForEach(viewModel.users , id: \.self) { item in
                Section(
                    content: {
                        UserCellView(user: item, geometry: geometry, url: URL(string: item.htmlURL)!)
                    }
                )
            }
        }
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
