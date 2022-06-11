//
//  ErrorView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 11.04.2022..
//

import Foundation
import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    var body: some View {
        ZStack {
            Text("Error! \(error.localizedDescription)")
                .font(.system(size: 20))
                .padding()
        }
    }
}
