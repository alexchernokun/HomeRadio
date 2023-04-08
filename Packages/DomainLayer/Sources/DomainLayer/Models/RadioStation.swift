//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct RadioStation: Codable, Hashable {
    public var type: CategoryType
    public var text: String
    public var url: URL?
    public var bitrate: String?
    public var reliability: String?
    public var subtext: String?
    public var formats: String?
    public var image: URL?
    public var currentTrack: String?
    public var playing: String?
    public var playingImage: String?
    public var metadata: String?
    public var artworkFromMetadata: URL?
    
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
        self.bitrate = (bitrate ?? "n/a") + " Kbps"
        self.reliability = (reliability ?? "n/a") + "%"
        self.subtext = subtext
        self.formats = formats
        self.image = URL(string: image ?? "") ?? nil
        self.currentTrack = currentTrack
        self.playing = playing
        self.playingImage = playingImage
        self.metadata = nil
        self.artworkFromMetadata = nil
    }
}
