//
//  MovieDetailRouter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

protocol MoviewDetailRouterProtocol: AnyObject {
    /// Shows the movie details
    /// - Parameters:
    ///     - movieID: The movie unique identifier
    ///     - fromVC: The view controller from which the detail view is presented
    ///     - movie: MovieViewModel instance
    func showMovieDetail(movieID: String, fromVC: UIViewController, movie: MovieViewModel)
}

class MovieDetailRouter: MoviewDetailRouterProtocol {
    func showMovieDetail(movieID: String, fromVC: UIViewController, movie: MovieViewModel) {
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(params: MovieDetailsPresenterParams(movieID: movieID, interactor: interactor, mapper: MovieDetailMapper(), movie: movie))
        let view = MovieDetailViewController(presenter: presenter)
        presenter.ui = view
        
        // Modal view
        fromVC.present(view, animated: true)
    }
}
