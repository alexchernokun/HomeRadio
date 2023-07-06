//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct RadioItem: Codable, Hashable {
    public var type: RadioItemType
    public var key: String?
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
    public var children: [RadioItem]?
    public var metadata: String?
    public var artworkFromMetadata: URL?
    
    public init(type: String?,
                key: String?,
                text: String,
                url: String?,
                bitrate: String?,
                reliability: String?,
                subtext: String?,
                formats: String?,
                image: String?,
                currentTrack: String?,
                playing: String?,
                playingImage: String?,
                children: [RadioItem]?) {
        self.type = RadioItemType(rawValue: type ?? "") ?? .unknown
        self.key = key
        self.text = text
        self.url = URL(string: url ?? "") ?? nil
        self.bitrate = (bitrate ?? "n/a") + " Kbps"
        self.reliability = (reliability ?? "n/a") + "%"
        self.subtext = subtext
        self.formats = formats
        self.image = URL(string: image ?? "") ?? nil
        self.currentTrack = currentTrack
        self.playing = playing
        self.playingImage = playingImage
        self.children = children
        self.metadata = nil
        self.artworkFromMetadata = nil
    }
    
    // For SwiftUI preview mock
    public init(type: RadioItemType = .audio, text: String, children: [RadioItem] = []) {
        self.type =  type
        self.text = text
        self.url = nil
        self.bitrate = "320 Kbps"
        self.reliability = "99"
        self.subtext = "Subtitle text"
        self.formats = "mp3"
        self.image = nil
        self.currentTrack = "Best Hit"
        self.playing = ""
        self.playingImage = ""
        self.children = children
        self.metadata = nil
        self.artworkFromMetadata = nil
    }
}
