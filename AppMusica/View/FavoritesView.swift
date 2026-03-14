//
//  FavoritesView.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.modelContext) private var modelContext
    
    @Query var favorites: [Music]
    
    var body: some View {
        if favorites.isEmpty {
            ContentUnavailableView(
                "Nenhuma Música Favorita",
                systemImage: "heart.slash",
                description: Text("Adicione músicas aos favoritos para vê-las aqui.")
            )
            .padding(.bottom, 80)
        } else {
            List {
                ForEach(favorites) { favorite in
                    Text(favorite.trackName)
                }
                .onDelete(perform: deleteFavorites)
            }
            .listStyle(.plain)
        }
    }
    
    func deleteFavorites(at offsets: IndexSet) {
        offsets.map { favorites[$0] }.forEach(modelContext.delete)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FavoritesView()
    }
}
