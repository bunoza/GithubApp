//
//  SheetView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        renderContentView()
    }
    
    func renderContentView() -> some View {
        VStack {
            renderDismissButton()
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
        }
    }
    
    func renderDismissButton() -> some View {
        Button("Close") {
            dismiss()
        }
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
            isChecked: true,
            title: "Repositories"
        ) {
            //viewModel.repositoriesChecked.toggle()
        }
        .padding()
    }
    
    func renderUsersCheckView() -> some View {
        CheckView(
            isChecked: false,
            title: "Users"
        ) {
            //viewModel.usersChecked.toggle()
        }
        .padding()
    }
    
}
