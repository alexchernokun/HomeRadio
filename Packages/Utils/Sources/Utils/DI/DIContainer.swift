//
//  File.swift
//
//
//  Created by Oleksandr Chornokun on 05/15/2022.
//

import Foundation

/// Dependency Injection Container for services
public final class DIContainer {
    public static let shared = DIContainer()
    
    private init() {}
    
    private var dependencies: [DependencyKey: Any] = [:]
    
    /// Method for service registration in DI Container
    /// - Parameters:
    ///   - type: type of service
    ///   - name: name of service (optional)
    ///   - service: instance of service
    public func register<T>(type: T.Type, name: String? = nil, service: Any) {
        let dependencyKey = DependencyKey(type: type, name: name)
        dependencies[dependencyKey] = service
    }

    /// Method for retrieving a service registered in DI Container
    /// - Parameters:
    ///   - type: type of service
    ///   - name: name of service (optional)
    /// - Returns: resolved service from container
    public func resolve<T>(type: T.Type, name: String? = nil) -> T {
        let dependencyKey = DependencyKey(type: type, name: name)
        return dependencies[dependencyKey] as! T
    }
    
}

public final class DependencyKey: Hashable, Equatable {
    private let type: Any.Type
    private let name: String?
    
    init(type: Any.Type, name: String? = nil) {
        self.type = type
        self.name = name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(name)
    }
    
    public static func == (lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        return lhs.type == rhs.type && lhs.name == rhs.name
    }
}
