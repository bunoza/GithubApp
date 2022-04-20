//
//  CustomButtonStyle.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 20.04.2022..
//

import Foundation
import SwiftUI

struct SearchButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(5)
            .frame(minWidth: 0, maxWidth: .infinity)
    }
}
