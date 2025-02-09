//
//  MovieDetailInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    func getDetailMovie(withID id: String) async throws -> MovieDetail {
        let movieDetailsService = MovieDetailsService()
        let movieDetails = try await movieDetailsService.getMovieDetails(movieId: id)
        
        return movieDetails
    }
}
