//
//  RepositoryCellView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

struct RepositoryCellView: View {
    @State private var isRepositoryPresented = false
    @State private var isAuthorPresented = false
    @State private var isBrowserPresented = false
    let repository: ReceivedRepository
    let geometry: GeometryProxy
    let url: URL
    
    var body: some View {
        createContent()
    }
    
    func createContent() -> some View {
        VStack {
            HStack {
                renderRepositoryInfo()
                    .padding(.vertical, 3)
                    .frame(width: geometry.size.width/2)
                renderNumbersInfo()
                    .padding(.vertical, 2)
                    .frame(width: geometry.size.width/3.5)
            }
            .onTapGesture {
                isRepositoryPresented.toggle()
            }
            .background(
                NavigationLink(
                    isActive: $isRepositoryPresented,
                    destination: {
                        WebView(request: URLRequest(url: url))
                            .navigationTitle(repository.name)
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            HStack {
                Button(
                    action: {
                        isAuthorPresented.toggle()
                    },
                    label: {
                        Text("Author details")
                    }
                )
                .background(
                    NavigationLink(
                        isActive: $isAuthorPresented,
                        destination: {
                            WebView(request: URLRequest(url: URL(string: repository.owner.htmlURL)!))
                                .navigationTitle(repository.owner.login)
                        },
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                )
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                Button {
                    UIApplication.shared.open(url)
                } label: {
                    Text("Open in Browser")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    func renderRepositoryInfo() -> some View {
        VStack {
            renderRepositoryName()
            renderAuthor()
            if let desc = repository.itemDescription {
                renderDescription(description: desc)
            }
        }
    }
    
    func renderRepositoryName() -> some View {
        HStack {
            Text(repository.name)
                .font(.title)
                .foregroundColor(.gray)
                .lineLimit(1)
            Spacer()
        }
    }
    
    func renderAuthor() -> some View {
        HStack {
            Text(repository.owner.login)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.vertical, 3)
            Spacer()
        }
    }
    
    func renderDescription(description: String) -> some View {
        HStack {
            Text(description)
                .font(.subheadline)
                .lineLimit(2)
            Spacer()
        }
    }
    
    func renderNumbersInfo() -> some View {
        VStack {
            renderWatching()
            renderIssues()
            renderForks()
            renderStars()
        }
    }
    
    func renderWatching() -> some View {
        HStack {
            Image(systemName: "eye")
            Spacer()
            Text("\(repository.watchersCount) watching")
                .font(.caption2)
                .lineLimit(1)
        }
        .padding(.vertical, 2)
    }
    
    func renderIssues() -> some View {
        HStack {
            Image(systemName: "smallcircle.filled.circle")
            Spacer()
            Text("\(repository.openIssuesCount) issues")
                .font(.caption2)
        }
        .padding(.vertical, 2)
    }
    
    func renderForks() -> some View {
        HStack {
            Image(systemName: "tuningfork")
            Spacer()
            Text("\(repository.forksCount) forks")
                .font(.caption2)
        }
        .padding(.vertical, 2)
    }
    
    func renderStars() -> some View {
        HStack {
            Image(systemName: "star")
            Spacer()
            Text("\(repository.stargazersCount) stars")
                .font(.caption2)
        }
        .padding(.vertical, 2)
    }
}
