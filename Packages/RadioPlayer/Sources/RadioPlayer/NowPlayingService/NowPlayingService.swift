//
//  NowPlayingManager.swift
//  RadioPlayer
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation
import MediaPlayer

/// An object for setting the Now Playing info
public struct NowPlayingService {
    
    public static let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    /// The method for setting track properties into NowPlaingInfoCenter
    /// - Parameter info: The info you want to show in NowPlayingInfoCenter
    public static func addNowPlayingInfo(from info: PlayingInfo) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        
        if let metadata = info.metadata {
            nowPlayingInfo[MPMediaItemPropertyTitle] = metadata
        } else {
            nowPlayingInfo[MPMediaItemPropertyTitle] = info.text
        }
        
        if let artworkUrl = info.artworkFromMetadata {
            getImage(from: artworkUrl, nowPlayingInfo)
        } else if let imageUrl = info.image {
            getImage(from: imageUrl, nowPlayingInfo)
        }
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }

    static func addArtwork(from image: UIImage?) {
        guard let image else { return }
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { (size) -> UIImage in
            return image
        }
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    private static func getImage(from url: URL, _ nowPlayingInfo: [String: Any]) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else {
                nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
                return
            }
            DispatchQueue.main.async {
                addArtwork(from: UIImage(data: data))
            }
        }
    }
    
}
