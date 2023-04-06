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
    public static func addNowPlayingInfo(from track: RadioStation) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
//        nowPlayingInfo[MPMediaItemPropertyArtist] = track.artist?.localizedCapitalized
//        nowPlayingInfo[MPMediaItemPropertyTitle] = track.title?.localizedCapitalized
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }

    static func addArtwork(from image: UIImage) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
}
