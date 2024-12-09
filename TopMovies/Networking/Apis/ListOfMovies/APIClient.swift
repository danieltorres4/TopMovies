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

// https://api.themoviedb.org/3/movie/top_rated?api_key=aac68339b14a798e91c45b11fd82e3ee&language=en-US&page=1

extension ListOfMoviesApi: EndPointType {
    var environmentBaseURL: String {
        return "https://api.themoviedb.org/3"
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
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key": "aac68339b14a798e91c45b11fd82e3ee", "language": Locale.preferredLanguages.first ?? "en-US", "page": page])
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
