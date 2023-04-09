//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Combine
import DomainLayer

public final class TuneInRepository {
    
    private let networkService = NetworkService()
    
    // MARK: Requests
    public func getGeneralTuneInCategories() -> AnyPublisher<[RadioItem], Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint(kind: .main))
        
        return networkService
            .send(request)
            .map { (response: GeneralTuneInResponse) -> [RadioItem] in
                return response.body.map { RadioItem($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public func getSubCategory(path: String, query: [String: String?]) -> AnyPublisher<GeneralTuneInResponse, Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint(kind: .subCategory(path, query)))
        
        return networkService
            .send(request)
            .map { (response: GeneralTuneInResponse) -> GeneralTuneInResponse in
                return response
            }
            .eraseToAnyPublisher()
    }
    
    public init() {}
}

public extension RadioItem {
    init(_ response: RadioItemResponse) {
        var radioStationChildren: [RadioItem]? = nil
        
        if let children = response.children {
            radioStationChildren = children.map { RadioItem($0) }
        }
        
        self.init(type: response.type,
                  key: response.key,
                  text: response.text,
                  url: response.url,
                  bitrate: response.bitrate,
                  reliability: response.reliability,
                  subtext: response.subtext,
                  formats: response.formats,
                  image: response.image,
                  currentTrack: response.currentTrack,
                  playing: response.playing,
                  playingImage: response.playingImage,
                  children: radioStationChildren)
    }
}
