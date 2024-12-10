//
//  APIClient.swift
//  TopMovies
//
//  Created by Daniel ST on 28/11/24.
//

import Foundation

public enum ListOfMoviesApi {
    case getTopRatedMovies(page: Int = 0)
}

extension ListOfMoviesApi: EndPointType {
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
        case .getTopRatedMovies: return "/movie/top_rated"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTopRatedMovies:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getTopRatedMovies(let page):
            let apiKey = configManager.getValue(forKey: "API_KEY") ?? ""
            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: [
                    "api_key": apiKey,
                    "language": Locale.preferredLanguages.first ?? "en-US",
                    "page": page
                ]
            )
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getTopRatedMovies:
            return [
                "accept": "application/json",
                "Authorization": "authValue".localized
            ]
        }
    }
}
