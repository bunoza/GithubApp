//
//  UserCellView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 07.04.2022..
//

import Foundation
import SwiftUI

struct UserCellView: View {
    
    let user: User
    let geometry: GeometryProxy
    let url: URL
    
    var body: some View {
        VStack {
            HStack {
                renderUserName()
                    .padding(.vertical, 3)
                    .frame(width: geometry.size.width/2)
                renderAvatar()
                    .padding(.vertical, 2)
                    .frame(width: geometry.size.width/4)
            }
            HStack {
                Button(
                    action: {
                        //                        open author details
                    },
                    label: {
                        Text("Author details")
                    }
                )
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                HStack {
                    NavigationLink(destination: { WebView(request: URLRequest(url: URL(string: user.htmlURL)!)) }, label: { Text("Open in browser") })
                    
                }
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
}

