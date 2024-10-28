//
//  MovieDetailRouter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

protocol MoviewDetailRouterProtocol: AnyObject {
    func showMovieDetail(movieID: String, fromVC: UIViewController, movie: MovieViewModel)
}

class MovieDetailRouter: MoviewDetailRouterProtocol {
    func showMovieDetail(movieID: String, fromVC: UIViewController, movie: MovieViewModel) {
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(params: MovieDetailsPresenterParams(movieID: movieID, interactor: interactor, mapper: MovieDetailMapper(), movie: movie))
        let view = MovieDetailViewController(presenter: presenter)
        presenter.ui = view
        
        fromVC.present(view, animated: true)
    }
}
