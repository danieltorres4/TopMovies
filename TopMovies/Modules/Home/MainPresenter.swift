//
//  MainPresenter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

protocol TopRatedMoviesPresenter: AnyObject {
    /// MainViewController reference
    var ui: TopRatedMoviesUI? { get }
    /// List of movies
    var movieViewModels: [MovieViewModel] { get }
    // General request information
    var currentPage: Int { get }
    var totalPages: Int { get }
    /// Triggered when the view appears
    /// - Parameters:
    ///     - page: page number to fetch movies from
    func onViewAppear(page: Int, pagination: Bool)
    /// Called when a movie is selected
    /// - Parameters:
    ///     - id: Selected movie id
    ///     - movie: MovieViewModel instance of the selected movie
    func selectedMovie(with id: Int, movie: MovieViewModel)
}

/// Methods required for updating the MainView
protocol TopRatedMoviesUI: AnyObject {
    func update(with movies: [MovieViewModel])
    func showAlert(with title: String, message: String)
    func showLoaderView(loaderView: LoaderView?)
    func hideLoaderView(loaderView: LoaderView?)
}

class MainPresenter: TopRatedMoviesPresenter {
    weak var ui: TopRatedMoviesUI?
    private let mapper: MovieMapper
    private let mainInteractor: TopRatedMoviesInteractor
    var movieViewModels: [MovieViewModel] = []
    private let router: MainRouterProtocol
    private var models: [Movie] = []
    var currentPage: Int = 0
    var totalPages: Int = 0
    
    init(params: MainPresenterParams, movieMapper: MovieMapper = MovieMapper()) {
        self.mainInteractor = params.mainInteractor
        self.mapper = movieMapper
        self.router = params.router
    }
    
    func onViewAppear(page: Int, pagination: Bool) {
        var loaderView: LoaderView? = LoaderView()
        ui?.showLoaderView(loaderView: loaderView)
        Task {
            // Fetches movies from the interactor with a given page. The very first time is 1
            do {
                let moviesResponse = try await mainInteractor.getListOfMovies(page: page)
                currentPage = moviesResponse.page
                totalPages = moviesResponse.totalPages
                models = moviesResponse.results
                
                // Mapping the received data
                let newModels = models.map(mapper.map(movie:))
                movieViewModels.append(contentsOf: newModels)
                ui?.update(with: newModels)
            } catch {
                debugPrint("Failed to fetch movies: \(error.localizedDescription)")
                await MainActor.run {
                    self.ui?.showAlert(with: "errorMessageTitle".localized, message: "errorMessageBody".localized)
                }
            }
        }
        ui?.hideLoaderView(loaderView: loaderView)
        loaderView = nil
    }
    
    func selectedMovie(with id: Int, movie: MovieViewModel) {
        let movieID = movieViewModels[id].id
        router.showMovieDetail(of: movieID.description, movie: movie)
    }
}
