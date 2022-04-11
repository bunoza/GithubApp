//
//  ContentView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct HomeScreen: View, HomeScreenDelegate {
    
    @ObservedObject private var viewModel: HomeScreenViewModel
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
                Spacer()
                renderLogoImage(geometry: geometry)
                renderSearchBar(geometry: geometry)
                renderSearchButton(geometry: geometry)
                Spacer()
                Spacer()
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
            .frame(width: geometry.size.width/4, height: geometry.size.height/4)
            .padding()
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
                            .font(.system(size: geometry.size.height/40))
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
    func toggleUsers()
    func toggleRepositories()
    func getUsers() -> Bool
    func getRepositories() -> Bool
}
