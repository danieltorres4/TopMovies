//
//  MainInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

/// Defines possible network errors
enum NetworkError: String, Error {
    case invalidURL = "Invalid URL"
    case dataError = "Data Error"
    case decodingError = "Decoding Error"
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case custom
}

class MainInteractor: TopRatedMoviesInteractor {
    func getListOfMovies(page: Int?) async throws -> TopRatedMovies {
        let topRatedMoviesService = ListOfMoviesService()
        let topRatedMovies = try await topRatedMoviesService.getTopRatedMovies(page: page ?? 1)
        
        return topRatedMovies
    }
}
