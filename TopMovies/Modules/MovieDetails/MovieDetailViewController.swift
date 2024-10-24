//
//  MovieDetailViewController.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let presenter: MovieDetailPresenterProtocol
    private let movieDetailView = MovieDetailView()
    
    init(presenter: MovieDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupViews()
        presenter.onViewAppear()
    }
    
    func setupViews() {
        view.addSubview(movieDetailView)
        movieDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension MovieDetailViewController: MovieDetailPresenterUI {
    func updateUI(with viewModel: MovieDetailViewModel, movie: MovieViewModel) {
        movieDetailView.movieTitle.text = movie.title
        movieDetailView.movieOverview.text = movie.overview
        movieDetailView.movieTagline.text = viewModel.tagline
        movieDetailView.movieReleaseDate.text = "releaseDateTitle".localized + movie.releaseDate
        movieDetailView.movieVoteAverage.text = "averageTitle".localized + String(movie.voteAverage)
        movieDetailView.movieHomepage.text = viewModel.homepage
        movieDetailView.movieImageView.loadFrom(from: movie.posterPath)
    }
}
