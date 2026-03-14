//
//  MusicResponse.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftData

struct MusicResponse: Codable {
    let results: [Music]
}

@Model
final class Music: Codable, Identifiable {
    @Attribute(.unique) var trackId: Int
    var trackName: String
    var collectionName: String

    var id: Int { trackId }

    init(trackId: Int, trackName: String, collectionName: String) {
        self.trackId = trackId
        self.trackName = trackName
        self.collectionName = collectionName
    }

    enum CodingKeys: String, CodingKey {
        case trackId, trackName, collectionName
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackId = try container.decode(Int.self, forKey: .trackId)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName) ?? "Sem álbum"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(trackId, forKey: .trackId)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(collectionName, forKey: .collectionName)
    }
}
