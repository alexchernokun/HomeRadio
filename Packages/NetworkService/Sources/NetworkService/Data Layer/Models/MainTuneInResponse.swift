//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

public struct MainTuneInResponse: Codable {
    public let body: [MainTuneInCategoryResponse]
}

public struct MainTuneInCategoryResponse: Codable {
    public let type: String
    public let text: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case type, text
        case url = "URL"
    }
}
