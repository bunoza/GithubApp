//
//  WebView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 08.04.2022..
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}
