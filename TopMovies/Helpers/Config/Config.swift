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
