//
//  NowPlayingManager.swift
//  Radio
//
//  Created by Oleksandr Chornokun on 4/6/21.
//

import Foundation
import MediaPlayer
import DomainLayer

public struct NowPlayingService {
    
    public static let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    public static func addNowPlayingInfo(from track: Track) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfo[MPMediaItemPropertyArtist] = track.artist?.localizedCapitalized
        nowPlayingInfo[MPMediaItemPropertyTitle] = track.title?.localizedCapitalized
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
//
//    static func addArtwork(from image: UIImage) {
//        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
//        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in
//            return image
//        })
//        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
//    }
//
//    static func addAlbumName(from trackModel: TrackModel) {
//        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
//        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = trackModel.albumName
//    }
    
}
