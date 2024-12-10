//
//  MovieDetailsService.swift
//  TopMovies
//
//  Created by Daniel ST on 09/12/24.
//

import Foundation

struct MovieDetailsService {
    let router = Router<MovieDetailsAPI>()
    
    func getMovieDetails(movieId: String) async throws -> MovieDetail {
        return try await withCheckedThrowingContinuation { continuation in
            router.request(.getMovieDetails(movieId: movieId)) { data, response, error in
                let res = decodeIt(data, response, error, dataType: MovieDetail.self)
                
                if let movieDetails = res.0 {
                    continuation.resume(returning: movieDetails)
                } else {
                    let errorMessage = res.1
                    continuation.resume(throwing: NetworkError.decodingError)
                }
            }
        }
    }
}
