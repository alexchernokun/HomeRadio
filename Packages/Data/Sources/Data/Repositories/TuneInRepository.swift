//
//  TuneInRepository.swift
//  Data
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation
import Combine
import Networking

public protocol TuneInRepositoryProtocol {
    func getMyStations() -> AnyPublisher<MyStationsResponse, Error>
    func getGeneralTuneInCategories() -> AnyPublisher<GeneralTuneInResponse, Error>
    func getSubCategory(path: String, query: [String: String?]) -> AnyPublisher<GeneralTuneInResponse, Error>
}

public final class TuneInRepository: TuneInRepositoryProtocol, ObservableObject {
    
    private let networkService = NetworkService()
    
    public func getMyStations() -> AnyPublisher<MyStationsResponse, Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint.myStations)
        
        return networkService
            .send(request)
            .eraseToAnyPublisher()
    }
    
    public func getGeneralTuneInCategories() -> AnyPublisher<GeneralTuneInResponse, Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint.main)
        
        return networkService
            .send(request)
            .eraseToAnyPublisher()
    }
    
    public func getSubCategory(path: String, query: [String: String?]) -> AnyPublisher<GeneralTuneInResponse, Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint.subCategory(path, query))
        
        return networkService
            .send(request)
            .eraseToAnyPublisher()
    }
    
    public init() {}
}
