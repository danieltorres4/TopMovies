//
//  TopRatedMovies.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct TopRatedMovies: Decodable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
