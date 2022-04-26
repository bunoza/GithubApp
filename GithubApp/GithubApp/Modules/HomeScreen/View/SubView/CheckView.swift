//
//  CheckView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct CheckView: View {
    
    @Binding var isChecked: Bool
    
    var title: String
    var action: () -> ()
    
    func toggle() {
        isChecked.toggle()
        action()
    }
    
    var body: some View {
        HStack {
            Button(action: toggle)
            {
                Image(systemName: isChecked ? "checkmark.square" : "square")
            }
            Text(title)
                .foregroundColor(.black)
            Spacer()
        }
    }
}
