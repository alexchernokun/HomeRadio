//
//  GeneralTuneInResponse.swift
//  Data
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation

public struct GeneralTuneInResponse: Codable {
    public let head: HeadResponse?
    public let body: [RadioItemResponse]
}

public struct HeadResponse: Codable {
    public let title: String?
}

