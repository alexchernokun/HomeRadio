//
//  PlayingInfo.swift
//  RadioPlayer
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation

public struct PlayingInfo {
    public let text: String?
    public let metadata: String?
    public let artworkFromMetadata: URL?
    public let image: URL?
    
    public init(text: String?, metadata: String?, artworkFromMetadata: URL?, image: URL?) {
        self.text = text
        self.metadata = metadata
        self.artworkFromMetadata = artworkFromMetadata
        self.image = image
    }
}
