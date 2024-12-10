//
//  MovieDetailsAPIClient.swift
//  TopMovies
//
//  Created by Daniel ST on 09/12/24.
//

import Foundation

public enum MovieDetailsAPI {
    case getMovieDetails(movieId: String)
}

extension MovieDetailsAPI: EndPointType {
    private var configManager: ConfigurationManager {
        return ConfigurationManager()
    }
    
    var environmentBaseURL: String {
        guard let envBaseURL = configManager.getValue(forKey: "API_BASE_URL") else { fatalError("envBaseURL could not be configured") }
        return envBaseURL
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getMovieDetails(movieId: let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovieDetails: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getMovieDetails:
            let apiKey = configManager.getValue(forKey: "API_KEY") ?? ""
            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: [
                    "api_key": apiKey, 
                    "language": Locale.preferredLanguages.first ?? "en-US"
                ]
            )
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getMovieDetails:
            return [
                "accept": "application/json",
                "Authorization": "authValue".localized
            ]
        }
    }
}
