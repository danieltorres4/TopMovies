//
//  MainPresenter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesPresenter: AnyObject {
    var ui: TopRatedMoviesUI? { get }
    var movieViewModels: [MovieViewModel] { get }
    func onViewAppear()
}

protocol TopRatedMoviesUI: AnyObject {
    func update(with movies: [MovieViewModel])
}

class MainPresenter: TopRatedMoviesPresenter {
    weak var ui: TopRatedMoviesUI?
    private let mapper: MovieMapper
    private let mainInteractor: TopRatedMoviesInteractor
    var movieViewModels: [MovieViewModel] = []
    
    init(mainInteractor: TopRatedMoviesInteractor, movieMapper: MovieMapper = MovieMapper()) {
        self.mainInteractor = mainInteractor
        self.mapper = movieMapper
    }
    
    func onViewAppear() {
        Task {
            let models = await mainInteractor.getListOfMovies().results
            movieViewModels = models.map(mapper.map(movie:))
            ui?.update(with: movieViewModels)
        }
    }
}
