//
//  MainPresenter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesUI: AnyObject {
    func update(with movies: [MovieViewModel])
}

class MainPresenter {
    var ui: TopRatedMoviesUI?
    private let mapper: MovieMapper
    private let mainInteractor: MainInteractor
    var movieViewModels: [MovieViewModel] = []
    
    init(mainInteractor: MainInteractor, movieMapper: MovieMapper = MovieMapper()) {
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
