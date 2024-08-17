//
//  MyStationsResponse.swift
//  Data
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation

public struct MyStationsResponse: Codable {
    public let data: [MyStationsResponseData]
}

public struct MyStationsResponseData: Codable {
    public let id: String
    public let description: String
    public let name: String
    public let imgURL: String
    public let streamURL: String
    public let reliability: Int
    public let popularity: Double?
    public let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case imgURL = "imgUrl"
        case tags, id
        case streamURL = "streamUrl"
        case popularity, description, name, reliability
    }
}
