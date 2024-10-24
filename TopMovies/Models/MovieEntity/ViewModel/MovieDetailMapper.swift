//
//  MovieDetailMapper.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct MovieDetailMapper {
    func map(movie: MovieDetail) -> MovieDetailViewModel {
        .init(overview: movie.overview, posterPath: ("imageURLPrefix".localized + (movie.posterPath ?? "")), releaseDate: movie.releaseDate ?? "", title: movie.title, voteAverage: movie.voteAverage ?? 0.0, homepage: movie.homepage ?? "", tagline: movie.tagline ?? "")
    }
}
