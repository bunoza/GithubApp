//
//  SheetView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: SettingsViewModel
    
    @State var users: Bool = false
    @State var repos: Bool = true
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    func setupBindings() {
        self.users = viewModel.savedSettings.isUsersChecked
        self.repos = viewModel.savedSettings.isRepositoriesChecked
    }
    
    var body: some View {
        NavigationView {
            renderContentView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Settings")
                .toolbar(
                    content: {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            renderDoneButton()
                        }
                    })
                .onAppear(
                    perform: {
                        setupBindings()
                    })
        }
        
    }
    
    func renderContentView() -> some View {
        VStack {
            Spacer()
            
            VStack {
                renderHeading()
                Divider()
                    .padding(.vertical)
                renderRepoCheckView()
                renderUsersCheckView()
            }
            .padding()
            
            Spacer()
            
            renderApplyButton()
        }
    }
    
    func renderDoneButton() -> some View {
        Button(
            action: {
                viewModel.saveSettings()
                dismiss()
            },
            label: {
                Text("Done")
            }
        )
    }
    
    func renderApplyButton() -> some View {
        Button("Apply") {
            viewModel.saveSettings()
            dismiss()
        }
        .buttonStyle(SearchButtonStyle())
        .padding()
    }
    
    func renderHeading() -> some View {
        HStack {
            Text("Look for:")
                .font(.largeTitle)
                .padding(.horizontal)
            Spacer()
        }
    }
    
    func renderRepoCheckView() -> some View {
        CheckView(
            isChecked: $repos,
            title: "Repositories"
        ) {
            viewModel.toggleRepositories()
            if viewModel.savedSettings.isUsersChecked == false && viewModel.savedSettings.isRepositoriesChecked == false {
                viewModel.toggleRepositories()
            }
        }
        .padding()
    }
    
    func renderUsersCheckView() -> some View {
        CheckView(
            isChecked: $users,
            title: "Users"
        ) {
            viewModel.toggleUsers()
            if viewModel.savedSettings.isUsersChecked == false && viewModel.savedSettings.isRepositoriesChecked == false {
                viewModel.toggleRepositories()
            }
        }
        .padding()
    }
}
