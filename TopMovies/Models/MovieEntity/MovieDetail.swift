//
//  MovieDetail.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct MovieDetail: Decodable {
    var overview: String
    var posterPath: String?
    var releaseDate: String?
    var title: String
    var voteAverage: Double?
    var homepage: String?
    var tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case title, overview, homepage, tagline
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
