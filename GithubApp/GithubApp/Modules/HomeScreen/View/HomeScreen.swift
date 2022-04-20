//
//  ContentView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject private var viewModel: HomeScreenViewModel
    
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            renderContentView()
                .navigationBarHidden(false)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        renderFilterButton()
                    }
                })
                .sheet(isPresented: $viewModel.showingSheet) {
                    NavigationView {
                        SheetView(viewModel: SheetViewModel(delegate: viewModel))
                    }
                }
        }
    }
    
    func renderContentView() -> some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    renderLogoImage()
                    Spacer()
                    renderSearchBar()
                    Spacer()
                    renderSearchButton()
                    Spacer()
                }
                .frame(width: geometry.size.width/2)
                
                Spacer()
            }
        }
    }
    
    func renderFilterButton() -> some View {
        Button(
            action: {
                viewModel.showingSheet.toggle()
            },
            label: {
                Image(systemName: "slider.vertical.3")
                    .resizable()
                    .foregroundColor(.black)
            }
        )
    }
    
    func renderLogoImage() -> some View {
        Image("github-icon")
            .resizable()
            .scaledToFit()
            .padding()
    }
    
    func renderSearchBar() -> some View {
        SearchBar(text: $viewModel.text)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.bottom)
    }
    
    func renderSearchButton() -> some View {
        NavigationLink(
            destination: {
                viewModel.searchResultViewBuilder(text: viewModel.text)
            }
        ) {
            Text("Search")
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .buttonStyle(SearchButtonStyle())
        .disabled(viewModel.queryIsEmpty(text: viewModel.text))
    }
}
