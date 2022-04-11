//
//  UserCellView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import SwiftUI

struct UserCellView: View {
    @State private var isDetailsPresentedFromCard = false
    @State private var isDetailsPresentedFromButton = false
    @State private var isBrowserPresented = false
    let user: User
    let geometry: GeometryProxy
    let url: URL
    
    var body: some View {
        createContent()
    }
    
    func createContent() -> some View {
        VStack {
            HStack {
                renderUserName()
                    .padding(.vertical, 3)
                    .frame(width: geometry.size.width/2)
                renderAvatar()
                    .padding(.vertical, 2)
                    .frame(width: geometry.size.width/3.5)
            }
            .onTapGesture {
                isDetailsPresentedFromCard.toggle()
            }
            .background(
                NavigationLink(
                    isActive: $isDetailsPresentedFromCard,
                    destination: {
                        WebView(request: URLRequest(url: url))
                            .navigationTitle(user.login)
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            HStack {
                Spacer()
                renderOpenProfileButton()
                renderOpenRepositoriesButton()
            }
        }
    }
    
    
    func renderUserName() -> some View {
        HStack {
            Text(user.login)
                .font(.title)
                .foregroundColor(.gray)
                .lineLimit(1)
            Spacer()
        }
    }
    
    func renderAvatar() -> some View {
        HStack {
            Spacer()
            AsyncImage(
                url: URL(string: user.avatarURL),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/6, height: geometry.size.height/6)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
    
    func renderOpenProfileButton() -> some View {
        ZStack {
            Button(
                action: {
                    isDetailsPresentedFromButton.toggle()
                    print(url)
                },
                label: {
                    Text("Open profile")
                }
            )
            .background(
                NavigationLink(
                    isActive: $isDetailsPresentedFromButton,
                    destination: {
                        WebView(request: URLRequest(url: url))
                            .navigationTitle(user.login)
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
    }
    
    func renderOpenRepositoriesButton() -> some View {
        ZStack {
            Button {
                if let validURL = URL(string: user.htmlURL + "?tab=repositories") {
                    UIApplication.shared.open(validURL)
                }
            } label: {
                Text("Open repositories")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

