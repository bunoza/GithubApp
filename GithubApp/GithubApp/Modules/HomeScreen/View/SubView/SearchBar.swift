//
//  SearchBar.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $text)
                .padding()
                .padding(.trailing)
                .background(Color(.systemGray6))
                .overlay(
                    renderSearchClearButton()
                )
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
    
    func renderSearchClearButton() -> some View {
        HStack {
            if isEditing {
                Spacer()
                Button(
                    action: {
                        self.text = ""
                    },
                    label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                )
            } else {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
            }
        }
    }
}
