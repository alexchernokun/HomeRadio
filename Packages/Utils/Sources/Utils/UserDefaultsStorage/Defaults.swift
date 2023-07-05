//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation

public final class Defaults {
    public static let myStationsKey = "defaultsStationsKey"
    public static let defaults = UserDefaults.standard
}

public extension Defaults {
    static func saveMyStations<T: Codable>(object: [T]?, for key: String) {
        guard let object = object else { return }
        
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            Logger.logError(message: "Falied to save object in UserDefaults")
        }
    }

    static func getMyStations<T: Codable>(for key: String) -> [T]? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        do {
            let object = try JSONDecoder().decode([T].self, from: data)
            return object
        } catch {
            Logger.logError(message: "Falied to get Data from UserDefaults")
            return nil
        }
    }
}
