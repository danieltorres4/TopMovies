//
//  StringExtensions.swift
//  TopMovies
//
//  Created by Daniel ST on 22/10/24.
//

import Foundation

// MARK: Localized strings
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
