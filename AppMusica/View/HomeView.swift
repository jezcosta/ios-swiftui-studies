//
//  HomeView.swift
//  AppMusica
//
//  Created by Jessica Costa on 27/02/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        ZStack {
            Text("Home")
            TabView {
                MusicListView()
                    .tabItem {
                        Label("Músicas", systemImage: "list.dash")
                    }

                FavoritesView()
                    .tabItem {
                        Label("Favoritos", systemImage: "heart")
                    }
                
            
                ProfileView()
                    .tabItem {
                        Label("Perfil", systemImage: "person")
                    }
                }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Sair") {
                    logout()
                }
            }
        }
    }
    
    private func logout() {
        withAnimation(.snappy) {
            appState.route = .login
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeView()
    }
}
