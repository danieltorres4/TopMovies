//
//  AppDataTypes.swift
//  TopMovies
//
//  Created by Daniel ST on 27/10/24.
//

import Foundation

// MARK: Movie Details
typealias MovieID = String

struct MovieDetailData {
    let movie: MovieViewModel
    let movieDetailViewModel: MovieDetailViewModel?
}

struct MovieDetailsPresenterParams {
    let movieID: MovieID
    let interactor: MovieDetailInteractorProtocol
    let mapper: MovieDetailMapper
    let movie: MovieViewModel
}

// MARK: Homepage (Top Rated Movies Table View)
struct MainPresenterParams {
    let mainInteractor: TopRatedMoviesInteractor
    let router: MainRouterProtocol
}

struct SelectedMovieParams {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
}
