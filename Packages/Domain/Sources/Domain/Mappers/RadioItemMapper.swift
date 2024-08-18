//
//  RadioItemMapper.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Data

struct RadioItemMapper {
    static func map(_ response: RadioItemResponse) -> RadioStationItem {
        var radioStationChildren: [RadioStationItem]? = nil
        
        if let children = response.children {
            radioStationChildren = children.map { map($0) }
        }
        
        return RadioStationItem(type: response.type,
                                key: response.key,
                                text: response.text,
                                url: response.url,
                                bitrate: response.bitrate,
                                reliability: response.reliability,
                                popularity: nil,
                                subtext: response.subtext,
                                formats: response.formats,
                                image: response.image,
                                currentTrack: response.currentTrack,
                                playing: response.playing,
                                playingImage: response.playingImage,
                                children: radioStationChildren,
                                tags: [])
    }
}
