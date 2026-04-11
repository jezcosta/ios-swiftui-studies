//
//  PlayerViewModel.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import Combine
import AVFoundation

final class PlayerViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var duration: TimeInterval = 0.0
    @Published private(set) var currentTime: TimeInterval = 0.0
    @Published var isPlaying: Bool = false
    @Published var currentURL: String?
    
    // MARK: - Private Properties
    private(set) var player: AVPlayer?
    private var timeObserver: Any?
    private var playerWithObserver: AVPlayer?
    
    // MARK: - Initialization
    init() {
        setupAudioSession()
    }
    
    deinit {
        cleanup()
    }
    
    // MARK: - Setup
    
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.duckOthers, .defaultToSpeaker])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Erro ao configurar sessão de áudio: \(error.localizedDescription)")
        }
    }
    
    func setupPlayer(url: String) {
        guard let url = URL(string: url) else { return }
        
        guard currentURL != url.absoluteString else { return }
        
        player?.pause()
        removeTimeObserver()
        
        player = AVPlayer(url: url)
        currentURL = url.absoluteString
        resetPlaybackState()
        addTimeObserver()
    }
    
    // MARK: - Playback Controls
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else if player != nil {
            play()
        }
    }
    
    func stop() {
        pause()
        cleanup()
    }
    
    // MARK: - Private Helpers
    
    private func resetPlaybackState() {
        currentTime = 0.0
        duration = 0.0
        isPlaying = false
    }
    
    private func cleanup() {
        player?.pause()
        removeTimeObserver()
        player = nil
        currentURL = nil
        currentTime = 0.0
        duration = 0.0
        isPlaying = false
    }
    
    private func addTimeObserver() {
        let interval = CMTime(value: 1, timescale: 2)
        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time.seconds
            self?.duration = self?.player?.currentItem?.duration.seconds ?? 0.0
        }
        
        playerWithObserver = player
        observePlayerEnd()
    }
    
    private func removeTimeObserver() {
        guard let timeObserver = timeObserver, let playerWithObserver = playerWithObserver else { return }
        playerWithObserver.removeTimeObserver(timeObserver)
        
        self.timeObserver = nil
        self.playerWithObserver = nil
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private func observePlayerEnd() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.isPlaying = false
            self?.player?.seek(to: .zero)
        }
    }
    
    // MARK: - Utilities
    
    func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, secs)
    }
}
