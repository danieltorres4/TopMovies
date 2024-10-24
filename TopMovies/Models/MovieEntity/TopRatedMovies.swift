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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decode([Movie].self, forKey: .results)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
}
