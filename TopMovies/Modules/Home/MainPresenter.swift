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
    func selectedMovie(with id: Int, movie: MovieViewModel)
}

protocol TopRatedMoviesUI: AnyObject {
    func update(with movies: [MovieViewModel])
}

class MainPresenter: TopRatedMoviesPresenter {
    weak var ui: TopRatedMoviesUI?
    private let mapper: MovieMapper
    private let mainInteractor: TopRatedMoviesInteractor
    var movieViewModels: [MovieViewModel] = []
    private let router: MainRouterProtocol
    private var models: [Movie] = []
    
    init(mainInteractor: TopRatedMoviesInteractor, movieMapper: MovieMapper = MovieMapper(), router: MainRouterProtocol) {
        self.mainInteractor = mainInteractor
        self.mapper = movieMapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            do {
                let moviesResponse = try await mainInteractor.getListOfMovies()
                debugPrint("Top Rated Movies: \(moviesResponse)")
                models = moviesResponse.results
                movieViewModels = models.map(mapper.map(movie:))
                ui?.update(with: movieViewModels)
            } catch {
                debugPrint("Failed to fetch movies: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(with id: Int, movie: MovieViewModel) {
        let movieID = models[id].id
        debugPrint(movieID)
        router.showMovieDetail(of: movieID.description, movie: movie)
    }
}
