//
//  HomeView.swift
//  AppMusica
//
//  Created by Jessica Costa on 27/02/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Text("Home")
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeView()
    }
}
