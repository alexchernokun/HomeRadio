//
//  UserDefaultsManager.swift
//  Persistence
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation

public final class UserDefaultsManager {
    private let database: UserDefaults
    
    public init() {
        self.database = .standard
    }
    
    func setValue<T>(_ value: T, key: UserDefaultsKey) {
        database.set(value, forKey: key.rawValue)
    }
    
    func getValue<T>(type: T.Type, key: UserDefaultsKey) -> T? {
        let object = database.object(forKey: key.rawValue) as? T
        return object
    }
    
    public func removeValue(key: UserDefaultsKey) {
        database.removeObject(forKey: key.rawValue)
    }
    
    public func removeAllValues() {
        UserDefaultsKey.allCases.forEach { removeValue(key: $0) }
    }
}
