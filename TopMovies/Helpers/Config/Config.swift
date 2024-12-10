//
//  Config.swift
//  TopMovies
//
//  Created by Daniel ST on 28/10/24.
//

import Foundation

func getConfigurationValue(forKey key: String) -> String? {
    guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"), let config = NSDictionary(contentsOfFile: path) else {
        return nil
    }
    return config[key] as? String
}

class ConfigurationManager {
    private let config: NSDictionary?
    
    init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            config = NSDictionary(contentsOfFile: path)
        } else {
            config = nil
        }
    }
    
    func getValue(forKey key: String) -> String? {
        return config?[key] as? String
    }
}
