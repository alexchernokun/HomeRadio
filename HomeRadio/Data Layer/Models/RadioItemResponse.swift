//
//  RadioItemResponse.swift
//  
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation

public struct GeneralTuneInResponse: Codable {
    public let head: HeadResponse?
    public let body: [RadioItemResponse]
}

public struct HeadResponse: Codable {
    public let title: String?
}

public struct RadioItemResponse: Codable {
    public let type: String?
    public let key: String?
    public let text: String
    public let url: String?
    public let bitrate: String?
    public let reliability: String?
    public let subtext: String?
    public let formats: String?
    public let image: String?
    public let currentTrack: String?
    public let playing: String?
    public let playingImage: String?
    public let children: [RadioItemResponse]?

    enum CodingKeys: String, CodingKey {
        case type, text, key
        case url = "URL"
        case bitrate, reliability
        case subtext
        case formats, image
        case currentTrack = "current_track"
        case playing
        case playingImage = "playing_image"
        case children
    }
}
