//
//  SearchBar.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    let geometry : GeometryProxy
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $text)
                .padding(geometry.size.width/25)
                .padding(.trailing, geometry.size.width/10)
                .background(Color(.systemGray6))
                .overlay(
                    renderSearchClearButton(geometry: geometry)
                )
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
    
    func renderSearchClearButton(geometry: GeometryProxy) -> some View {
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
                            .padding(.trailing, geometry.size.width/25)
                    }
                )
            } else {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, geometry.size.width/25)
            }
        }
    }
}
