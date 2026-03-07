//
//  MusicListView.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftUI

struct MusicListView: View {
    @EnvironmentObject private var appState: AppState
    @State private var musics = [Music]()
    @State private var isLoading = false
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            if isLoading {
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.4)
                    
                    Text("Carregando músicas...")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            } else {
                List(musics, id: \.trackId) { item in
                    HStack {
                        
                        Image(systemName: "music.note")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        
                        VStack(alignment: .leading) {
                            Text(item.trackName)
                                .font(.headline)
                            
                            Text(item.collectionName)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Button {
                        } label: {
                            Image(systemName: "heart")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            BottomSearchBar(searchText: $searchText)
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        isLoading = true
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodeResponse = try? JSONDecoder().decode(MusicResponse.self, from: data) {
                musics = decodeResponse.results
            }
        } catch {
            print("Invalid data")
        }
        
        isLoading = false
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MusicListView()
    }
}
