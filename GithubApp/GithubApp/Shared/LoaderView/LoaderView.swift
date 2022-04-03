//
//  LoaderView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 02.04.2022..
//

import Foundation
import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            ProgressView().progressViewStyle(.circular)
        }
    }
}
