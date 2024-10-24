//
//  MainRouter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    var movieDetailRouter: MoviewDetailRouterProtocol? { get }
    var topRatedMoviesView: MainViewController? { get }
    func showTopRatedMovies(window: UIWindow?)
    func showMovieDetail(of movieID: String, movie: MovieViewModel)
}

class MainRouter: MainRouterProtocol {
    // Component connection
    var topRatedMoviesView: MainViewController?
    var movieDetailRouter: MoviewDetailRouterProtocol?
    
    func showTopRatedMovies(window: UIWindow?) {
        self.movieDetailRouter = MovieDetailRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(mainInteractor: interactor, router: self)
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
