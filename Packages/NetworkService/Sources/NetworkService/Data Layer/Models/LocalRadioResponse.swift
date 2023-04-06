//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

struct GeneralLocalRadioResponse: Codable {
    let body: [LocalRadioBodyResponse]
}

struct LocalRadioBodyResponse: Codable {
    let text: String
    let children: [RadioStationResponse]
}
