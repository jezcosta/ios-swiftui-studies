//
//  PlayerViewModel.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import Combine
import AVFoundation
import Combine
import AVFoundation

final class PlayerViewModel: ObservableObject {
    
    @Published private(set) var duration: TimeInterval = 0.0
    @Published private(set) var currentTime: TimeInterval = 0.0
    @Published var isPlaying: Bool = false
    @Published var currentURL: String?
    
    private(set) var player: AVPlayer?
    private var timeObserver: Any?
    private var endObserver: Any?
    private var playerWithObserver: AVPlayer?
    private var isEditingSlider = false
    private var isSeeking = false
    
    init() {
        setupAudioSession()
    }
    
    deinit {
        cleanup()
    }
    
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
        removeObservers()
        
        player = AVPlayer(url: url)
        currentURL = url.absoluteString
        resetPlaybackState()
        addTimeObserver()
        observePlayerEnd()
    }
    
    func play() {
        guard let player = player else { return }
        
        player.play()
        isPlaying = true
        
        let playerTime = player.currentTime().seconds
        if playerTime.isFinite && !playerTime.isNaN {
            currentTime = max(0, playerTime)
        }
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func stop() {
        pause()
        cleanup()
    }
    
    func setSliderEditing(_ isEditing: Bool) {
        isEditingSlider = isEditing
        
        if !isEditing {
            seek(to: currentTime)
        }
    }
    
    func updateSliderTime(_ value: Double) {
        currentTime = value
    }
    
    func seek(to time: Double) {
        guard let player = player else { return }
        
        isSeeking = true
        currentTime = time
        
        let targetTime = CMTime(seconds: time, preferredTimescale: 600)
        
        player.seek(
            to: targetTime,
            toleranceBefore: .zero,
            toleranceAfter: .zero
        ) { [weak self] _ in
            guard let self = self else { return }
            
            let playerTime = player.currentTime().seconds
            if playerTime.isFinite && !playerTime.isNaN {
                self.currentTime = max(0, playerTime)
            } else {
                self.currentTime = time
            }
            
            self.isSeeking = false
        }
    }
    
    private func resetPlaybackState() {
        currentTime = 0
        duration = 0
        isPlaying = false
        isEditingSlider = false
        isSeeking = false
    }
    
    private func cleanup() {
        player?.pause()
        removeObservers()
        player = nil
        currentURL = nil
        currentTime = 0
        duration = 0
        isPlaying = false
        isEditingSlider = false
        isSeeking = false
    }
    
    private func addTimeObserver() {
        let interval = CMTime(seconds: 0.2, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            guard let self = self else { return }
            
            if !self.isEditingSlider && !self.isSeeking {
                let seconds = time.seconds
                if seconds.isFinite && !seconds.isNaN {
                    self.currentTime = max(0, seconds)
                }
            }
            
            let durationSeconds = self.player?.currentItem?.duration.seconds ?? 0
            if durationSeconds.isFinite && !durationSeconds.isNaN {
                self.duration = durationSeconds
            }
        }
        
        playerWithObserver = player
    }
    
    private func observePlayerEnd() {
        endObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.isPlaying = false
            self.currentTime = 0
            self.player?.seek(to: .zero)
        }
    }
    
    private func removeObservers() {
        if let timeObserver, let playerWithObserver {
            playerWithObserver.removeTimeObserver(timeObserver)
            self.timeObserver = nil
            self.playerWithObserver = nil
        }
        
        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
            self.endObserver = nil
        }
    }
    
    func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite && !seconds.isNaN else { return "0:00" }
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, secs)
    }
}
