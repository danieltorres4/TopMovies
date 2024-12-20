//
//  MovieMapper.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

struct MovieMapper {
    // Using MovieViewModel in order to only get the used data
    func map(movie: Movie) -> MovieViewModel {
        MovieViewModel(id: movie.id, title: movie.title, posterPath: ("imageURLPrefix".localized + (movie.posterPath ?? "")), releaseDate: movie.releaseDate ?? "defaultValue".localized, overview: movie.overview, voteAverage: movie.voteAverage ?? 0.0)
    }
}
