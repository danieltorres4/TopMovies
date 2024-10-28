//
//  MainInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesInteractor: AnyObject {
    func getListOfMovies(page: Int?) async throws -> TopRatedMovies
}

enum NetworkError: Error {
    case invalidURL
    case dataError
    case decodingError
}

class MainInteractor: TopRatedMoviesInteractor {
    func getListOfMovies(page: Int?) async throws -> TopRatedMovies {
        guard let apiKey = getConfigurationValue(forKey: "API_KEY"), let baseURL = getConfigurationValue(forKey: "API_BASE_URL"), let url = URL(string: "\(baseURL)/movie/top_rated?api_key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page ?? 1)")
        ]
        
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "authValue".localized
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
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
