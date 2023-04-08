//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct GeneralTuneInCategory: Hashable {
    public var type: RadioItemType
    public var text: String
    public var url: URL?
    
    public init(type: String,
                text: String,
                url: String) {
        self.type = RadioItemType(rawValue: type) ?? .unknown
        self.text = text
        self.url = URL(string: url) ?? nil
    }
}

public enum RadioItemType: String, Codable {
    case link
    case audio
    case unknown
}
