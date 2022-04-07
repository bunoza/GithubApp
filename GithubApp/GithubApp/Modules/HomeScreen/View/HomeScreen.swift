//
//  ContentView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct HomeScreen: View, HomeScreenDelegate {
    
    @ObservedObject var viewModel: HomeScreenViewModel
    
    @State private var showingSheet = false
    @State var text: String = ""
    
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
        }
        .sheet(isPresented: $showingSheet) {
            SheetView(delegate: self)
        }
    }
    
    func renderContentView() -> some View {
        GeometryReader { geometry in
            VStack {
                renderLogoImage(geometry: geometry)
                renderSearchBar(geometry: geometry)
                renderSearchButton(geometry: geometry)
            }
        }
    }
    
    func renderFilterButton() -> some View {
        Button(
            action: {
                showingSheet.toggle()
            },
            label: {
                Image(systemName: "slider.vertical.3")
                    .resizable()
                    .foregroundColor(.black)
            }
        )
    }
    
    func renderLogoImage(geometry: GeometryProxy) -> some View {
        Image("github-icon")
            .resizable()
            .scaledToFit()
            .padding(geometry.size.height/7)
    }
    
    func renderSearchBar(geometry: GeometryProxy) -> some View {
        SearchBar(text: $text, geometry: geometry)
            .padding(.horizontal, geometry.size.width/7)
            .padding(.bottom)
    }
    
    func renderSearchButton(geometry: GeometryProxy) -> some View {
        NavigationLink(
            destination: {
                CollectionScreen(
                    viewModel: CollectionScreenViewModel(
                        usersSelected: viewModel.usersSelected,
                        repositoriesSelected: viewModel.repositoriesSelected,
                        githubRepository: GithubRepositoryImpl(),
                        userRepository: UsersRepositoryImpl(),
                        searchQuery: text
                    )
                )
            },
            label: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: geometry.size.width/3.5, height: geometry.size.height/20)
                    .foregroundColor(.black)
                    .overlay(content: {
                        Text("SEARCH")
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    })
            }
        )
    }
    
    //MARK: - DELEGATE IMPL
    func toggleUsers() {
        viewModel.didToggleUsers()
    }
    
    func toggleRepositories() {
        viewModel.didToggleRepositories()
    }
    
    func getUsers() -> Bool {
        return viewModel.usersSelected
    }
    
    func getRepositories() -> Bool {
        return viewModel.repositoriesSelected
    }
}

//MARK: - DELEGATE
protocol HomeScreenDelegate {
    func toggleRepositories()
    func toggleUsers()
    func getRepositories() -> Bool
    func getUsers() -> Bool
}
