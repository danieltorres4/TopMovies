//
//  MovieDetailPresenter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    var ui: MovieDetailPresenterUI? { get }
    var movieID: String { get }
    var movie: MovieViewModel { get }
    func onViewAppear()
}

protocol MovieDetailPresenterUI: AnyObject {
    func updateUI(with viewModel: MovieDetailViewModel, movie: MovieViewModel)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var ui: MovieDetailPresenterUI?
    private let interactor: MovieDetailInteractorProtocol
    let movieID: String
    let movie: MovieViewModel
    private let mapper: MovieDetailMapper
    
    init(movieID: String, interactor: MovieDetailInteractor, mapper: MovieDetailMapper, movie: MovieViewModel) {
        self.movieID = movieID
        self.movie = movie
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            let model = await interactor.getDetailMovie(withID: movieID)
            let viewModel = mapper.map(movie: model)
            debugPrint(viewModel)
            await MainActor.run {
                self.ui?.updateUI(with: viewModel, movie: movie)
            }
        }
    }
}
