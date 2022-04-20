//
//  UDManager.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 18/04/22.
//

import Foundation

class UDManager {
    static  let shared      = UDManager()
    private let defaults    = UserDefaults.standard
    private let encoder     = JSONEncoder()
    private let decoder     = JSONDecoder()
    
    func save<T:Codable>(object: T, for key: DataKey) -> Bool {
        if let encodedObject = try? encoder.encode(object) {
            defaults.set(encodedObject, forKey: key.rawValue)
            return true
        } else {
            return false
        }
    }
    
    func set<T>(value: T, for key: DataKey) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getValue<T>(for key: DataKey, ofType type: T.Type) -> T? {
        var fetchedValue: T?
        if let savedValue = defaults.object(forKey: key.rawValue) as? T {
            fetchedValue = savedValue
        }
        
        return fetchedValue
    }
    
    func getObjet<T: Codable>(for key: DataKey, ofType type: T.Type) -> T? {
        var fetchedObject: T?
        if let encodedObject = defaults.object(forKey: key.rawValue) as? Data {
            if let decodedObject = try? decoder.decode(type, from: encodedObject) {
                fetchedObject = decodedObject
            }
        }
        
        return fetchedObject
    }
    
    func clearDefaults() {
        DataKey.allCases.forEach { defaults.removeObject(forKey: $0.rawValue) }
    }
}
