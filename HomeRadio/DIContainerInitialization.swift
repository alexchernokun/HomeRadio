//
//  DIContainerInitialization.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import RadioPlayer
import NetworkService
import Utils

final class DIContainerInitialization {
    
    // MARK: Properties
    private let container = DIContainer.shared
    
    // MARK: Methods
    private func registerModuleBuilders() {
        container.register(type: MyStationsModuleBuilder.self,
                           service: MyStationsModuleBuilder())
        container.register(type: BrowseMainCategoriesModuleBuilder.self,
                           service: BrowseMainCategoriesModuleBuilder())
    }
    
    private func registerServices() {
        container.register(type: RadioPlayer.self,
                           service: RadioPlayer())
    }
    
    private func registerRepositories() {
        container.register(type: TuneInRepositoryProtocol.self,
                           service: TuneInRepository())
        container.register(type: ItunesSearchRepositoryProtocol.self,
                           service: ItunesSearchRepository())
    }
    
    // MARK: Initialization
    @discardableResult
    init() {
        registerModuleBuilders()
        registerServices()
        registerRepositories()
    }
}
