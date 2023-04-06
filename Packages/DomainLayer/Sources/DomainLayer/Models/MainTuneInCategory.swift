//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct MainTuneInCategory: Hashable {
    public var type: CategoryType
    public var text: String
    public var url: URL?
    
    public init(type: String,
                text: String,
                url: String) {
        self.type = CategoryType(rawValue: type) ?? .unknown
        self.text = text
        self.url = URL(string: url) ?? nil
    }
}

public enum CategoryType: String {
    case link
    case audio
    case unknown
}
