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
                var radioStations = [RadioStation]()
                for item in response.body {
                    radioStations.append(contentsOf: item.children.map { RadioStation($0) })
                }
                return radioStations
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
