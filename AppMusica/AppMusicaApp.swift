//
//  AppMusicaApp.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import SwiftUI
import SwiftData

@main
struct AppMusicaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
            }
            .modelContainer(for: [UserAccount.self], inMemory: true)
        }
    }
}
