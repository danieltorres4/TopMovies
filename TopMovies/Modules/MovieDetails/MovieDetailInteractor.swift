//
//  MovieDetailInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    /// Retrieves the movie information by its ID
    /// - Parameter id: The movie unique identifier
    /// - Returns: Asynchronous `MovieDetail` object containing the movie's details
    /// - Throws: Throws and error if the fetching fails
    func getDetailMovie(withID id: String) async throws -> MovieDetail
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    func getDetailMovie(withID id: String) async throws -> MovieDetail {
        let movieDetailsService = MovieDetailsService()
        let movieDetails = try await movieDetailsService.getMovieDetails(movieId: id)
        
        return movieDetails
    }
}
