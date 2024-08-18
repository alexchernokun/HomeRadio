//
//  TuneInRepository.swift
//  Data
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation
import Combine
import Persistence
import Networking

public protocol TuneInRepository {
    func fetchMyStations() -> AnyPublisher<MyStationsResponse, Error>
    func getCachedStations() -> MyStationsResponse?
    func getRadioStationTags() -> [String]
    func getGeneralTuneInCategories() -> AnyPublisher<GeneralTuneInResponse, Error>
    func getSubCategory(path: String, query: [String: String?]) -> AnyPublisher<GeneralTuneInResponse, Error>
}

public final class TuneInRepositoryImpl: TuneInRepository, ObservableObject {
    
    private let networkService = NetworkService()
    private let userDefaultsManager: UserDefaultsManager
    private var cachedStationsResponse: MyStationsResponse?
    
    public func fetchMyStations() -> AnyPublisher<MyStationsResponse, Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint.myStations)
        
        return networkService
            .send(request)
            .map { [weak self] (response: MyStationsResponse) -> MyStationsResponse in
                self?.saveMyStations(from: response)
                self?.saveRadioStationTags(from: response)
                return response
            }
            .eraseToAnyPublisher()
    }
    
    public func getCachedStations() -> MyStationsResponse? {
        return cachedStationsResponse
    }
    
    public func getRadioStationTags() -> [String] {
        return userDefaultsManager.tags ?? []
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
    
    public init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
}

private extension TuneInRepositoryImpl {
    
    func saveMyStations(from response: MyStationsResponse) {
        cachedStationsResponse = response
    }
    
    func saveRadioStationTags(from response: MyStationsResponse) {
        let uniqueTags = Set(response.data.flatMap { $0.tags })
        userDefaultsManager.tags = Array(uniqueTags)
    }
}
