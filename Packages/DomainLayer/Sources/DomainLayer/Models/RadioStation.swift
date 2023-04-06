//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct RadioStation {
    public var type: CategoryType
    public var text: String
    public var url: URL?
    public var bitrate: String?
    public var reliability: String?
    public var subtext: String?
    public var formats: String?
    public var image: String?
    public var currentTrack: String?
    public var playing: String?
    public var playingImage: String?
    
    public init(type: String,
                text: String,
                url: String,
                bitrate: String?,
                reliability: String?,
                subtext: String?,
                formats: String?,
                image: String?,
                currentTrack: String?,
                playing: String?,
                playingImage: String?) {
        self.type = CategoryType(rawValue: type) ?? .unknown
        self.text = text
        self.url = URL(string: url) ?? nil
        self.bitrate = bitrate
        self.reliability = reliability
        self.subtext = subtext
        self.formats = formats
        self.image = image
        self.currentTrack = currentTrack
        self.playing = playing
        self.playingImage = playingImage
    }
}
