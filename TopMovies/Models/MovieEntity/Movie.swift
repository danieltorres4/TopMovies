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
    var releaseDate: String?
    var title: String
    var voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
}
