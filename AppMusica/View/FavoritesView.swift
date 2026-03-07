//
//  FavoritesView.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        ZStack {
            Text("Favorites")
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FavoritesView()
    }
}
