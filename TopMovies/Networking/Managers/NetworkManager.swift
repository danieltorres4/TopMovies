//
//  NetworkManager.swift
//  TopMovies
//
//  Created by Daniel ST on 28/11/24.
//

import Foundation

// MARK: Environment
enum NetworkEnvironment {
    case qa
    case production
    case staging
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

func decodeIt<T: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, dataType: T.Type) -> (T?, String) {
        
    if error != nil {
        return (nil, "")
    }
    
    if let response = response as? HTTPURLResponse {
        let result = handleNetworkResponse(response)
        switch result {
        case .success:
            guard let responseData = data else {
                return (nil, NetworkResponse.noData.rawValue)
            }
            do {
                print(responseData)
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                print(jsonData)
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                return (apiResponse, NetworkResponse.success.rawValue)
            } catch {
                print(error)
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
        case .failure(let networkFailureError):
            return (nil, networkFailureError)
        }
    } else {
        return (nil, NetworkResponse.badRequest.rawValue)
    }
}

private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
}
