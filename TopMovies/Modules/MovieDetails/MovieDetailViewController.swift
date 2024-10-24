//
//  MovieDetailViewController.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let presenter: MovieDetailPresenterProtocol
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "BebasNeue-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieReleaseDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieVoteAverage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieTagline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieHomepage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        view.addSubview(movieImageView)
        view.addSubview(movieTitle)
        view.addSubview(movieOverview)
        view.addSubview(movieTagline)
        view.addSubview(movieReleaseDate)
        view.addSubview(movieVoteAverage)
        view.addSubview(movieHomepage)
        
        // Constraints for movieImageView (centered at the top)
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // Constraints for movieTitle (below movieImageView)
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieOverview (below movieTitle)
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 16),
            movieOverview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieOverview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieOverview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieTagline (below movieOverview)
        NSLayoutConstraint.activate([
            movieTagline.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 16),
            movieTagline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTagline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieTagline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieReleaseDate (left side below movieTagline)
        NSLayoutConstraint.activate([
            movieReleaseDate.topAnchor.constraint(equalTo: movieTagline.bottomAnchor, constant: 16),
            movieReleaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieReleaseDate.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        // Constraints for movieVoteAverage (right side next to movieReleaseDate)
        NSLayoutConstraint.activate([
            movieVoteAverage.centerYAnchor.constraint(equalTo: movieReleaseDate.centerYAnchor),
            movieVoteAverage.leadingAnchor.constraint(equalTo: movieReleaseDate.trailingAnchor, constant: 16),
            movieVoteAverage.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieHomepage (centered below movieReleaseDate and movieVoteAverage)
        NSLayoutConstraint.activate([
            movieHomepage.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 16),
            movieHomepage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieHomepage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieHomepage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

}

extension MovieDetailViewController: MovieDetailPresenterUI {
    func updateUI(with viewModel: MovieDetailViewModel, movie: MovieViewModel) {
        movieTitle.text = movie.title
        movieOverview.text = viewModel.overview
        movieTagline.text = viewModel.tagline
        movieReleaseDate.text = movie.releaseDate
        movieVoteAverage.text = String(viewModel.voteAverage)
        movieHomepage.text = viewModel.homepage
        movieImageView.loadFrom(from: movie.posterPath ?? "")
    }
}
