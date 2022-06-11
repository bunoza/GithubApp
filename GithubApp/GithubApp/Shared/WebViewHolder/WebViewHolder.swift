//
//  WebViewHolder.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 29.04.2022..
//

import Foundation
import SwiftUI

struct WebViewHolder: View {
    
    @Environment(\.dismiss) var dismiss

    let url: URL
    let title: String
    
    var body: some View {
        ZStack{
            WebView(request: URLRequest(url: url))
                .navigationTitle(title)
                .navigationBarBackButtonHidden(true)
                .toolbar(
                    content: {
                        ToolbarItem(placement: .navigationBarLeading)
                        {
                            Button(
                                action: {
                                    dismiss()
                                }
                            )
                            {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                )

        }
    }
    
}
