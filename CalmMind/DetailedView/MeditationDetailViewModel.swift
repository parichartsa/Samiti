import Foundation
import AVFoundation
class MeditationDetailViewModel: ObservableObject {
    
    @Published var selectedIndex = 0
    @Published var radioURLs: [String]
    @Published var model: MeditationModel
    var audioURL: URL
    
    init(model: MeditationModel, audioURL: URL) {
        self.radioURLs = [
            "http://mediaserv30.live-streams.nl:8086/live",
            "http://mediaserv33.live-streams.nl:8034/live",
            "http://mediaserv38.live-streams.nl:8006/live",
            "http://mediaserv33.live-streams.nl:8036/live",
            "http://mediaserv30.live-streams.nl:8000/live",
            "http://mediaserv30.live-streams.nl:8088/live",
            "http://mediaserv38.live-streams.nl:8027/live",
            "http://mediaserv21.live-streams.nl:8000/live"
        ]
        self.model = model
        self.audioURL = audioURL
    }
    
//    func previewsTrackTapped() {
//        if selectedIndex >= 1 {
//            AudioManager.shared.pause()
//            selectedIndex -= 1
//            AudioManager.shared.play(url: URL(string: radioURLs[selectedIndex]))
//        }
//    }
//    
//    func nextTrackTapped() {
//        if selectedIndex < radioURLs.count - 1 {
//            AudioManager.shared.pause()
//            selectedIndex += 1
//            AudioManager.shared.play(url: URL(string: radioURLs[selectedIndex]))
//        }
//    }
    
    func pausePlayTrackTapped() {
        AudioManager.shared.togglePlayPause()
    }
}
