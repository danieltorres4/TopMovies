//
//  MainInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesInteractor: AnyObject {
    /// Asynchronous method to fetch the list of the top rated movies from the API
    /// - Parameter page: page number for the top rated movies request. Defaults to 1.
    /// - Throws: May throw a `Network Error` if an issue occurs
    /// - Returns: Returns a `TopRatedMovies` object
    func getListOfMovies(page: Int?) async throws -> TopRatedMovies
}

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
