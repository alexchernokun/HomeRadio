//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation

final public class ItunesSearchResponse: Codable {
    public let resultCount: Int
    public let results: [ItunesSearchResult]
}

extension ItunesSearchResponse: CustomStringConvertible {
    public var description: String {
        return "[ItunesSearchResponse]: I found \(resultCount) results of this song on Itunes"
    }
}

public final class ItunesSearchResult: Codable {
    public let artistID: Int?
    public let albumID: Int?
    public let trackID: Int?
    public let artistName: String?
    public let albumName: String?
    public let trackName: String?
    public let artworkUrl100: String?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case albumID = "collectionId"
        case trackID = "trackId"
        case artistName
        case albumName = "collectionName"
        case trackName
        case artworkUrl100
    }
    
    public var artworkUrl: URL? {
        guard let artworkUrl = artworkUrl100?.replacingOccurrences(of: "100x100", with: "640x640") else { return nil }
        return URL(string: artworkUrl)
    }
    
    public var smallArtworkUrl: URL? {
        guard let artworkUrl = artworkUrl100 else { return nil }
        return URL(string: artworkUrl)
    }
}
