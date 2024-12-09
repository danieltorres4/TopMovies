//
//  ListOfMoviesService.swift
//  TopMovies
//
//  Created by Daniel ST on 28/11/24.
//

import Foundation

struct ListOfMoviesService {
    let router = Router<ListOfMoviesApi>()
    
    func getTopRatedMovies(page: Int = 1) async throws -> TopRatedMovies {
        return try await withCheckedThrowingContinuation { continuation in
            router.request(.getTopRatedMovies(page: page)) { data, response, error in
                let res = decodeIt(data, response, error, dataType: TopRatedMovies.self)
                
                if let topRatedMovies = res.0 {
                    continuation.resume(returning: topRatedMovies)
                } else {
                    let errorMessage = res.1
                    continuation.resume(throwing: NetworkError.decodingError)
                }
            }
        }
    }
}
