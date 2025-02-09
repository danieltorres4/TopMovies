//
//  MovieDetailsProtocols.swift
//  TopMovies
//
//  Created by Daniel Sanchez Torres on 08/02/25.
//

import Foundation
import UIKit

// MARK: - View
/// Presenter -> View:  Methods required for updating the MainView
/// Methods required for updating the MovieDetailView
protocol MovieDetailPresenterUI: AnyObject {
    func updateUI(with data: MovieDetailData?)
    func showAlert(with title: String, message: String)
}

// MARK: - Interactor
/// Interactor -> Presenter
protocol MovieDetailInteractorOutputProtocol: AnyObject {
}

/// Presenter -> Interactor
protocol MovieDetailInteractorProtocol {
    /// Retrieves the movie information by its ID
    /// - Parameter id: The movie unique identifier
    /// - Returns: Asynchronous `MovieDetail` object containing the movie's details
    /// - Throws: Throws and error if the fetching fails
    func getDetailMovie(withID id: String) async throws -> MovieDetail
}

// MARK: - Presenter
/// View -> Presenter
protocol MovieDetailPresenterProtocol: AnyObject {
    /// MovieDetailViewController reference
    var ui: MovieDetailPresenterUI? { get }
    /// Movie unique identifier
    var movieID: MovieID { get }
    /// Selected movie
    var movie: MovieViewModel { get }
    /// Triggered when the view appears
    func onViewAppear()
}

// MARK: - Router
/// Presenter -> Router
protocol MoviewDetailRouterProtocol: AnyObject {
    /// Shows the movie details
    /// - Parameters:
    ///     - movieID: The movie unique identifier
    ///     - fromVC: The view controller from which the detail view is presented
    ///     - movie: MovieViewModel instance
    func showMovieDetail(movieID: String, fromVC: UIViewController, movie: MovieViewModel)
}

// MARK: - Data Manager
/// Interactor -> Local Data Manager
protocol MovieDetailLocalDataManagerInputProtocol: AnyObject {
}

/// Interactor -> Remote Data Manager
protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
}

/// Remote Data Manager -> Interactor
protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
}
