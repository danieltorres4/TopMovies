//
//  MovieDetailInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    func getDetailMovie(withID id: String) async throws -> MovieDetail
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    func getDetailMovie(withID id: String) async throws -> MovieDetail {
        guard let apiKey = getConfigurationValue(forKey: "API_KEY"), let baseURL = getConfigurationValue(forKey: "API_BASE_URL"), let url = URL(string: "\(baseURL)/movie/\(id)?api_key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                do {
                    let movieDetails = try JSONDecoder().decode(MovieDetail.self, from: data)
                    return movieDetails
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
