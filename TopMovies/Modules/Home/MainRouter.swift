//
//  MainRouter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

/// Defines the routing functionalities for the MainView and the navigation between MainView and MovieDetailView
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

class MainRouter: MainRouterProtocol {
    // Component connection
    var topRatedMoviesView: MainViewController?
    var movieDetailRouter: MoviewDetailRouterProtocol?
    
    func showTopRatedMovies(window: UIWindow?) {
        self.movieDetailRouter = MovieDetailRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(params: MainPresenterParams(mainInteractor: interactor, router: self))
        topRatedMoviesView = MainViewController(presenter: presenter)
        presenter.ui = topRatedMoviesView
        
        window?.rootViewController = topRatedMoviesView
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetail(of movieID: String, movie: MovieViewModel) {
        guard let vc = topRatedMoviesView else { return }
        movieDetailRouter?.showMovieDetail(movieID: movieID, fromVC: vc, movie: movie)
    }
}
