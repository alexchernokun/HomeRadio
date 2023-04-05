//
//  ItunesSearchModel.swift
//  Radio
//
//  Created by Oleksandr Chornokun on 4/8/21.
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
    public let artistViewURL: String?
    public let albumViewURL: String?
    public let trackViewURL: String?
    public let trackPreviewURL: String?
    public let artworkUrl100: String?
    public let releaseDate: String?
    public let country: String?
    public let primaryGenreName: String?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case albumID = "collectionId"
        case trackID = "trackId"
        case artistName
        case albumName = "collectionName"
        case trackName
        case artistViewURL = "artistViewUrl"
        case albumViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case trackPreviewURL = "previewUrl"
        case artworkUrl100
        case releaseDate
        case country
        case primaryGenreName
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

extension ItunesSearchResult: CustomStringConvertible {
    public var description: String {
        return """
            [ItunesSearchResult]:
            trackName: \(trackName ?? "n/a")
            artistName: \(artistName ?? "n/a")
            albumName: \(albumName ?? "n/a")
            artistViewURL: \(artistViewURL ?? "n/a")
            albumViewURL: \(albumViewURL ?? "n/a")
            trackViewURL: \(trackViewURL ?? "n/a")
            artworkUrl100: \(artworkUrl100 ?? "n/a")
            releaseDate: \(releaseDate ?? "n/a")
            """
    }
}
