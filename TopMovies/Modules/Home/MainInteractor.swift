//
//  MainInteractor.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesInteractor: AnyObject {
    func getListOfMovies() async -> TopRatedMovies
}

class MainInteractor: TopRatedMoviesInteractor {
    func getListOfMovies() async -> TopRatedMovies {
        let apiKey = "apiKey".localized
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")!
        
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(TopRatedMovies.self, from: data)
    }
}
