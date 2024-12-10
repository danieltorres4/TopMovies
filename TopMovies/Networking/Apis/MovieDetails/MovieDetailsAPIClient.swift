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
    var environmentBaseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured")}
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
        case .getMovieDetails(let movieDetail):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key": "aac68339b14a798e91c45b11fd82e3ee", "language": Locale.preferredLanguages.first ?? "en-US"])
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
