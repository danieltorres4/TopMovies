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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init(presenter: MovieDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showMovieDetails()
    }
    
    private func showMovieDetails() {
        presenter.onViewAppear()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieDetailView)
        movieDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            movieDetailView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}

extension MovieDetailViewController: MovieDetailPresenterUI {
    func updateUI(with data: MovieDetailData?) {
        guard let data = data, let movieDetailViewModel = data.movieDetailViewModel else {
            movieDetailView.movieImageView.image = UIImage(systemName: "icloud.slash.fill")
            movieDetailView.movieTitle.text = data?.movie.title
            movieDetailView.movieOverview.text = data?.movie.overview
            return
        }
        let movie = data.movie
        
        movieDetailView.movieTitle.text = movie.title
        movieDetailView.movieOverview.text = movie.overview
        movieDetailView.movieTagline.text = movieDetailViewModel.tagline
        movieDetailView.movieReleaseDate.text = "releaseDateTitle".localized + movie.releaseDate
        movieDetailView.movieVoteAverage.text = "averageTitle".localized + String(movie.voteAverage)
        movieDetailView.movieHomepage.text = movieDetailViewModel.homepage
        
        if let homepageURL = URL(string: movieDetailViewModel.homepage), homepageURL.scheme == "urlScheme".localized {
            movieDetailView.configureView(with: "movieHomepageAction".localized, homepageURL: homepageURL)
        } else {
            movieDetailView.movieHomepage.textColor = UIColor(named: "FontColor")
            movieDetailView.configureView(with: "notAvailableDomain".localized, homepageURL: nil)
        }
        
        movieDetailView.movieImageView.loadFrom(from: movie.posterPath)
    }
    
    func showAlert(with title: String, message: String) {
        showAlertOneAction(title: title, message: message)
    }
}
