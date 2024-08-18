//
//  RadioItem.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct RadioStationItem: Hashable {
    public var type: RadioItemType
    public var key: RadioStationItemKey
    public var text: String
    public var url: URL?
    public var bitrate: String?
    public var reliability: String?
    public var popularity: Double?
    public var subtext: String?
    public var formats: String?
    public var image: URL?
    public var currentTrack: String?
    public var playing: String?
    public var playingImage: String?
    public var children: [RadioStationItem]?
    public var metadata: String?
    public var artworkFromMetadata: URL?
    public var tags: [String]?
    
    public init(type: String?,
                key: String?,
                text: String,
                url: String?,
                bitrate: String?,
                reliability: String?,
                popularity: Double?,
                subtext: String?,
                formats: String?,
                image: String?,
                currentTrack: String?,
                playing: String?,
                playingImage: String?,
                children: [RadioStationItem]?,
                tags: [String]?) {
        self.type = RadioItemType(rawValue: type ?? "") ?? .unknown
        self.key = RadioStationItemKey(rawValue: key ?? "") ?? .unknown
        self.text = text
        self.url = URL(string: url ?? "") ?? nil
        self.bitrate = (bitrate ?? "n/a") + " Kbps"
        self.reliability = (reliability ?? "n/a") + "%"
        self.popularity = popularity
        self.subtext = subtext
        self.formats = formats
        self.image = URL(string: image ?? "") ?? nil
        self.currentTrack = currentTrack
        self.playing = playing
        self.playingImage = playingImage
        self.children = children
        self.metadata = nil
        self.artworkFromMetadata = nil
        self.tags = tags
    }
}
