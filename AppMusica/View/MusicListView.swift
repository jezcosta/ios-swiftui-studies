//
//  MusicListView.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftUI

struct MusicListView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        ZStack {
            Text("Musics")
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MusicListView()
    }
}
