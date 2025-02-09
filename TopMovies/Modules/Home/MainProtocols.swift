//
//  MainProtocols.swift
//  TopMovies
//
//  Created by Daniel Sanchez Torres on 08/02/25.
//

import Foundation
import UIKit

// MARK: - View
/// Presenter -> View:  Methods required for updating the MainView
protocol TopRatedMoviesUI: AnyObject {
    func update(with movies: [MovieViewModel])
    func showAlert(with title: String, message: String)
    func showLoaderView(loaderView: LoaderView?)
    func hideLoaderView(loaderView: LoaderView?)
}

// MARK: - Interactor
/// Interactor -> Presenter
protocol TopRatedMoviesInteractorOutputProtocol: AnyObject {
}

/// Presenter -> Interactor
protocol TopRatedMoviesInteractor: AnyObject {
    /// Asynchronous method to fetch the list of the top rated movies from the API
    /// - Parameter page: page number for the top rated movies request. Defaults to 1.
    /// - Throws: May throw a `Network Error` if an issue occurs
    /// - Returns: Returns a `TopRatedMovies` object
    func getListOfMovies(page: Int?) async throws -> TopRatedMovies
}

// MARK: - Presenter
/// View -> Presenter
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

// MARK: - Router
/// Presenter -> Router: Defines the routing functionalities for the MainView and the navigation between MainView and MovieDetailView
protocol MainRouterProtocol: AnyObject {
    /// Handles navigation
    var movieDetailRouter: MoviewDetailRouterProtocol? { get }
    /// MainViewController reference
    var topRatedMoviesView: MainViewController? { get }
    /// Displays the top rated ovies as the root view controller
    /// - Parameter window: Main application window
    func showTopRatedMovies(window: UIWindow?)
    /// Navigates to the MovieDetailViewController
    /// - Parameters:
    ///     - movieID: unique identifier of a movie
    ///     - movie: MovieViewModel instance that contains movie data
    func showMovieDetail(of movieID: String, movie: MovieViewModel)
}

// MARK: - Data Manager
/// Interactor -> Local Data Manager
protocol MainLocalDataManagerInputProtocol: AnyObject {
}

/// Interactor -> Remote Data Manager
protocol MainRemoteDataManagerInputProtocol: AnyObject {
}

/// Remote Data Manager -> Interactor
protocol MainRemoteDataManagerOutputProtocol: AnyObject {
}
