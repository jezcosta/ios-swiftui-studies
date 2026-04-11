//
//  NowPlayingBar.swift
//  AppMusica
//
//  Created by Jessica Costa on 11/04/26.
//

import SwiftUI

struct NowPlayingBar: View {
    let music: Music
    @ObservedObject var playerViewModel: PlayerViewModel
    let onTap: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(
                colors: [
                    Color(.systemGroupedBackground).opacity(0),
                    Color(.systemGroupedBackground).opacity(0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 18)
            
            VStack(spacing: 8) {
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: music.artworkUrl30)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "music.note")
                            .foregroundStyle(.blue)
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(music.trackName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                        Text(music.collectionName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button {
                        if playerViewModel.currentURL != music.previewUrl {
                            playerViewModel.setupPlayer(url: music.previewUrl)
                            playerViewModel.play()
                        } else {
                            playerViewModel.togglePlayPause()
                        }
                    } label: {
                        Image(systemName: playerViewModel.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color.blue))
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                    .buttonStyle(.plain)
                }
                
                VStack(spacing: 4) {
                    ProgressView(value: playerViewModel.currentTime, total: playerViewModel.duration)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(height: 3)
                    
                    HStack {
                        Text(playerViewModel.formatTime(playerViewModel.currentTime))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(playerViewModel.formatTime(playerViewModel.duration))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .background(Color(.systemGroupedBackground))
            .onTapGesture(perform: onTap)
        }
    }
}
