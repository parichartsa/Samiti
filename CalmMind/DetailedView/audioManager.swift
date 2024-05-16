import Foundation
import AVFoundation
import Combine

class AudioManager: NSObject, ObservableObject {
    static let shared = AudioManager()
    
    @Published var isPlaying = false
    @Published var progress: Double = 0.0
    
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    override init() {
        
        super.init()
        // Initialize AVAudioPlayer
        guard let audioURL = Bundle.main.url(forResource: "music1", withExtension: "mp3") else {
            fatalError("Audio file not found")
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error initializing AVAudioPlayer: \(error)")
        }
    }
    
    // Play audio
    func play(url: URL) {
            guard let audioPlayer = try? AVAudioPlayer(contentsOf: url) else {
                print("Error initializing AVAudioPlayer")
                return
            }
            self.audioPlayer = audioPlayer
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            isPlaying = true
            startTimer()
        }
    
    // Pause audio
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
        stopTimer()
    }
    
    // Toggle play/pause
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play(url: Bundle.main.url(forResource: "music1", withExtension: "mp3")!)
        }
    }
    
    // Start progress update timer
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if let duration = self.audioPlayer?.duration, duration > 0 {
                self.progress = self.audioPlayer!.currentTime / duration
            }
        }
    }
    
    // Stop progress update timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        stopTimer()
    }
}
