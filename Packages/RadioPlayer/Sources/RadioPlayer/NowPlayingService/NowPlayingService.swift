//
//  NowPlayingManager.swift
//  Radio
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation
import MediaPlayer
import DomainLayer

/// An object for setting the Now Playing info
public struct NowPlayingService {
    
    public static let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    /// The method for setting track properties into NowPlaingInfoCenter
    /// - Parameter track: The track you want to show in NowPlayingInfoCenter
    public static func addNowPlayingInfo(from track: RadioItem?) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        if let metadata = track?.metadata {
            nowPlayingInfo[MPMediaItemPropertyTitle] = metadata
        } else {
            nowPlayingInfo[MPMediaItemPropertyTitle] = track?.text
        }
        
        if let artwork = track?.artworkFromMetadata {
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: artwork) else {
                    nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
                    return
                }
                DispatchQueue.main.async {
                    addArtwork(from: UIImage(data: data))
                }
            }
        } else if let image = track?.image {
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: image) else {
                    nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
                    return
                }
                DispatchQueue.main.async {
                    addArtwork(from: UIImage(data: data))
                }
            }
        }
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }

    static func addArtwork(from image: UIImage?) {
        guard let image else { return }
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
}
