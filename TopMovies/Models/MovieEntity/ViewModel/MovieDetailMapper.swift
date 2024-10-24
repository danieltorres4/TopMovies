//
//  MovieDetailMapper.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct MovieDetailMapper {
    func map(movie: MovieDetail) -> MovieDetailViewModel {
        .init(homepage: movie.homepage ?? "", tagline: movie.tagline ?? "")
    }
}
