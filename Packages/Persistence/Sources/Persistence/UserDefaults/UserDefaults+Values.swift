//
//  UserDefaults+Values.swift
//  Persistence
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation

public extension UserDefaultsManager {
    var tags: [String]? {
        get { getValue(type: [String].self, key: .tags) }
        set { setValue(newValue, key: .tags) }
    }
}
