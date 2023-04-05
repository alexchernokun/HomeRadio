//
//  File.swift
//
//
//  Created by Oleksandr Chornokun on 05/15/2022.
//

import Foundation

public struct Track {
    public var title: String?
    public var artist: String?
    
    public init(title: String?, artist: String?) {
        self.title = title
        self.artist = artist
    }
}

extension Track: CustomStringConvertible {
    public var description: String {
        return "\(artist ?? "") - \(title ?? "")"
    }
}
