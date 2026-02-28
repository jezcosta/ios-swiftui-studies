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
