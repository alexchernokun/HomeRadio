//
//  MyStationsMapper.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Data

struct MyStationsMapper {
    static func map(_ response: MyStationsResponse) -> [RadioStationItem] {
        return response.data.map { RadioStationItem(type: "audio",
                                                    key: nil,
                                                    text: $0.name,
                                                    url: $0.streamURL,
                                                    bitrate: nil,
                                                    reliability: String($0.reliability),
                                                    popularity: $0.popularity,
                                                    subtext: $0.description,
                                                    formats: nil,
                                                    image: $0.imgURL,
                                                    currentTrack: nil,
                                                    playing: nil,
                                                    playingImage: nil,
                                                    children: nil,
                                                    tags: $0.tags) }
    }
}
