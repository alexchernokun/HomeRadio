//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Combine
import DomainLayer

public final class LocalRadioRepository {
    
    private let networkService = NetworkService()
    
    // MARK: Requests
    public func getLocalRadioStations() -> AnyPublisher<[RadioStation], Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint(kind: .local))
        
        return networkService
            .send(request)
            .map { (response: GeneralLocalRadioResponse) -> [RadioStation] in
                return response.body.first!.children.map { RadioStation($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public init() {}
}

extension RadioStation {
    init(_ response: RadioStationResponse) {
        self.init(type: response.type,
                  text: response.text,
                  url: response.url,
                  bitrate: response.bitrate,
                  reliability: response.reliability,
                  subtext: response.subtext,
                  formats: response.formats,
                  image: response.image,
                  currentTrack: response.currentTrack,
                  playing: response.playing,
                  playingImage: response.playingImage)
    }
}
