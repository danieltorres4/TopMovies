//
//  MainInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesInteractor: AnyObject {
    func getListOfMovies() async throws -> TopRatedMovies
}

enum NetworkError: Error {
    case invalidURL
    case dataError
    case decodingError
}

class MainInteractor: TopRatedMoviesInteractor {
    func getListOfMovies() async throws -> TopRatedMovies {
        let apiKey = "apiKey".localized
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                do {
                    let movies = try JSONDecoder().decode(TopRatedMovies.self, from: data)
                    return movies
                } catch {
                    throw NetworkError.decodingError
                }
            } else {
                throw NetworkError.dataError
            }
        } catch {
            throw NetworkError.dataError
        }
    }
}
