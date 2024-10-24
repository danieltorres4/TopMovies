//
//  MovieDetailInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    func getDetailMovie(withID id: String) async -> MovieDetail
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    func getDetailMovie(withID id: String) async -> MovieDetail {
        let url = URL(string: "mainURL".localized + "\(id)?api_key=" + "apiKey".localized)!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! jsonDecoder.decode(MovieDetail.self, from: data)
    }
}
