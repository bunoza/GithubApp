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
                    .frame(width: geometry.size.width/2)
                
                renderAvatar()
            }
            .frame(height: geometry.size.height/6)
            .onTapGesture {
                isDetailsPresentedFromCard.toggle()
            }
            .background(
                NavigationLink(
                    isActive: $isDetailsPresentedFromCard,
                    destination: {
                        WebViewHolder(url: url, title: user.login)
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            HStack {
                renderOpenProfileButton()
                renderOpenRepositoriesButton()
            }
            .padding(.bottom)
        }
    }
    
    
    func renderUserName() -> some View {
        HStack {
            Text(user.login)
                .font(.title2)
                .foregroundColor(.gray)
                .lineLimit(1)
            Spacer()
        }
    }
    
    func renderAvatar() -> some View {
        HStack {
            AsyncImage(
                url: URL(string: user.avatarURL),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/4, height: geometry.size.height/4)
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
                        WebViewHolder(url: url, title: user.login)
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            .buttonStyle(SearchButtonStyle())
        }
    }
    
    func renderOpenRepositoriesButton() -> some View {
        ZStack {
            Button {
                if let validURL = URL(string: user.htmlURL + RestEndpoints.usersRepositoriesAddon) {
                    UIApplication.shared.open(validURL)
                }
            } label: {
                Text("Open repositories")
                    .font(.system(size: geometry.size.width/27))
            }
            .buttonStyle(SearchButtonStyle())
        }
    }
}

