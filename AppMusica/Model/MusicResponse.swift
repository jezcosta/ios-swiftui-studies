//
//  MusicResponse.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

struct MusicResponse: Codable {
    let results: [Music]
}

struct Music: Codable, Identifiable {
    let trackId: Int
    let trackName: String
    let collectionName: String
    
    var id: Int { trackId }
}
