//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation

struct RadioStationResponse: Codable {
    let type: String
    let text: String
    let url: String
    let bitrate: String?
    let reliability: String?
    let subtext: String?
    let formats: String?
    let image: String?
    let currentTrack: String?
    let playing: String?
    let playingImage: String?

    enum CodingKeys: String, CodingKey {
        case type, text
        case url = "URL"
        case bitrate, reliability
        case subtext
        case formats, image
        case currentTrack = "current_track"
        case playing
        case playingImage = "playing_image"
    }
}
