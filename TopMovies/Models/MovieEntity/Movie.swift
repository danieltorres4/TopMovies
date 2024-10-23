//
//  Movie.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct Movie: Decodable {
    var id: Int
    var overview: String
    var posterPath: String?
    var releaseDate: String
    var title: String
    var voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
