//
//  AnyTransition+Extensions.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 03.05.2022..
//

import SwiftUI

extension AnyTransition {
    static var swapRight: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing)
        )
    }
    static var swapLeft: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .leading)
        )
    }
}
