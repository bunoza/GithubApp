//
//  ContentView.swift
//  GithubApp
//
//  Created by Domagoj Bunoza on 28.03.2022..
//

import SwiftUI

struct Homescreen: View {
    
    @State private var showingSheet = false
    @State var text: String = ""
    
    var body: some View {
        renderContentView()
    }
    
    func renderContentView() -> some View {
        GeometryReader { geometry in
            VStack {
                renderFilterButton(geometry: geometry)
                renderLogoImage(geometry: geometry)
                renderSearchBar(geometry: geometry)
                renderSearchButton()
            }
        }
    }
    
    func renderFilterButton(geometry: GeometryProxy) -> some View {
        HStack {
            Spacer()
            Button(
                action: {
                    showingSheet.toggle()
                },
                label: {
                    Image(systemName: "slider.vertical.3")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: geometry.size.width/10, height: geometry.size.width/10)
                }
            )
            .padding()
            .sheet(isPresented: $showingSheet) {
                SheetView()
            }
        }
    }
    
    func renderLogoImage(geometry: GeometryProxy) -> some View {
        Image("github-icon")
            .resizable()
            .scaledToFit()
            .padding(geometry.size.height/7)
    }
    
    func renderSearchBar(geometry: GeometryProxy) -> some View {
        SearchBar(text: $text)
            .padding(.horizontal, geometry.size.width/7)
            .padding(.bottom)
    }
    
    func renderSearchButton() -> some View {
        Button(
            action: {
                //LAUNCH COLLECTION SCREEN (API results)
            },
            label: {
                Text("SEARCH")
                    .foregroundColor(Color.gray)
                    .padding(.horizontal)
            }
        )
        .buttonStyle(.bordered)
        .padding()
    }
}

struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
    }
}
