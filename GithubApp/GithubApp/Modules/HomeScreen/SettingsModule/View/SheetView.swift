//
//  SheetView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    let viewModel: SheetViewModel
    
    init(viewModel: SheetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        renderContentView()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    renderDoneButton()
                }
            })
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
                dismiss()
            },
            label: {
                Text("Done")
            }
        )
    }
    
    func renderApplyButton() -> some View {
        Button("Apply") {
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
            isChecked: viewModel.delegate.getRepositories(),
            title: "Repositories"
        ) {
            viewModel.toggleRepositories()
            if viewModel.delegate.getUsers() == false && viewModel.delegate.getRepositories() == false {
                viewModel.toggleRepositories()
            }
        }
        .padding()
    }
    
    func renderUsersCheckView() -> some View {
        CheckView(
            isChecked: viewModel.delegate.getUsers(),
            title: "Users"
        ) {
            viewModel.toggleUsers()
            if viewModel.delegate.getUsers() == false && viewModel.delegate.getRepositories() == false {
                viewModel.toggleRepositories()
            }
        }
        .padding()
    }
    
}
