//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Combine
import DomainLayer

public final class MainTuneInRepository {
    
    private let networkService = NetworkService()
    
    // MARK: Requests
    public func getMainTuneInCategories() -> AnyPublisher<[MainTuneInCategory], Error> {
        let request = Request(apiEndpoint: TuneInAPIEndpoint(kind: .main))
        
        return networkService
            .send(request)
            .map { (response: MainTuneInResponse) -> [MainTuneInCategory] in
                return response.body.map { MainTuneInCategory($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public init() {}
}

extension MainTuneInCategory {
    init(_ response: MainTuneInCategoryResponse) {
        self.init(type: response.type,
                  text: response.text,
                  url: response.url)
    }
}
