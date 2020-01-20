//
//  ActivityMediaView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 16/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI
import AVFoundation
import CoreMedia

enum PlayerState {
    case idle
    case loading
    case playing
}

struct ActivityVideoView: View {

    var videoUrl: String
    var imageUrl: String

    var videoPlayerView: VideoPlayerView

    @ObservedObject
    var videoPlayer: VideoPlayer

    init(videoURL: String, imageURL: String) {
        self.videoUrl = videoURL
        self.imageUrl = imageURL
        videoPlayerView = VideoPlayerView(videoURL: videoUrl)
        videoPlayer = videoPlayerView.videoPlayer
    }

    var body: some View {
        ZStack {
            videoPlayerView
            if videoPlayer.state == .idle {
                Image(uiImage: UIImage.init(named: "activity-image.video-play-image")!).onTapGesture {
                    self.videoPlayer.play()
                }
            }
        }.background(Color.black)
    }
}

//struct ActivityMediaView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityMediaView(placeholder: "activity-image.default-image", videoUrl: "https://cdn.getsocial.im/21208109381005007/ACTIVITY_FEED/app/4e255e7b2a656308f7e2ff5f64d32524aa8f64c0b2c811c0cb82082455a87975.mp4", imageUrl: "")
//    }
//}


struct VideoPlayerView: UIViewRepresentable {

    var uiView: VideoPlayerLayerView

    var videoPlayer: VideoPlayer

    init(videoURL: String) {
        self.uiView = VideoPlayerLayerView()
        self.videoPlayer = VideoPlayer.init(videoURL: videoURL, layer: uiView.layer as! AVPlayerLayer)
    }

    func makeUIView(context: Context) -> UIView {
        return uiView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

}

class VideoPlayerLayerView: UIView {

    override class var layerClass: AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
}

class VideoPlayer: ObservableObject {

    var videoPlayer: AVPlayer?

    @Published
    var state: PlayerState

    var videoURL: String
    var videoLayer: AVPlayerLayer
    var videoObserver: NSObjectProtocol?

    init(videoURL: String, layer: AVPlayerLayer) {
        self.videoURL = videoURL
        self.videoLayer = layer
        self.state = .idle
        load()
    }

    func videoFinished() {
        self.state = .idle
        self.videoPlayer?.seek(to: CMTime.zero)
    }

    func play() {
        self.videoPlayer?.play()
        self.state = .playing
    }

    private func load() {
        self.videoObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer, queue: nil, using: { _ in
            self.videoFinished()
        })

        let urlAsset = AVURLAsset.init(url: URL(string: videoURL)!)
        urlAsset.loadValuesAsynchronously(forKeys: ["playable"]) {
            let playerItem = AVPlayerItem.init(asset: urlAsset)
            self.videoPlayer = AVPlayer.init(playerItem: playerItem)
            self.videoLayer.player = self.videoPlayer
        }
    }

}
