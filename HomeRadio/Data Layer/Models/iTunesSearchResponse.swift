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

public final class ItunesSearchResult: Codable {
    public let artworkUrl100: String?
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl100
    }
    
    public var artworkUrl: URL? {
        guard let artworkUrl = artworkUrl100?.replacingOccurrences(of: "100x100", with: "640x640") else { return nil }
        return URL(string: artworkUrl)
    }
}
