//
//  MovieDetailPresenter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

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

/// Methods required for updating the MovieDetailView
protocol MovieDetailPresenterUI: AnyObject {
    func updateUI(with data: MovieDetailData?)
    func showAlert(with title: String, message: String)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var ui: MovieDetailPresenterUI?
    private let interactor: MovieDetailInteractorProtocol
    let movieID: String
    let movie: MovieViewModel
    private let mapper: MovieDetailMapper
    
    init(params: MovieDetailsPresenterParams) {
        self.movieID = params.movieID
        self.movie = params.movie
        self.interactor = params.interactor
        self.mapper = params.mapper
    }
    
    func onViewAppear() {
        Task {
            // Fetch movie details from the interactor
            do {
                let movieDetails = try await interactor.getDetailMovie(withID: movieID)
                let viewModel = mapper.map(movie: movieDetails)
                debugPrint(viewModel)
                let viewData = MovieDetailData(movie: movie, movieDetailViewModel: viewModel)
                await MainActor.run {
                    self.ui?.updateUI(with: viewData)
                }
            } catch {
                debugPrint("Failed to get movie details: \(error)")
                await MainActor.run {
                    self.ui?.updateUI(with: MovieDetailData(movie: movie, movieDetailViewModel: nil))
                    self.ui?.showAlert(with: "errorMessageTitle".localized, message: "errorMessageBody".localized)
                }
            }
        }
    }
}
