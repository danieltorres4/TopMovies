//
//  MovieDetail.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct MovieDetail: Decodable {
    var homepage: String?
    var tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage, tagline
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
    }
}
