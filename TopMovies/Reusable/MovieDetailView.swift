//
//  MovieDetailView.swift
//  TopMovies
//
//  Created by Daniel ST on 24/10/24.
//

import UIKit

class MovieDetailView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(movieImageView)
        addSubview(movieTitle)
        addSubview(movieOverview)
        addSubview(movieTagline)
        addSubview(movieReleaseDate)
        addSubview(movieVoteAverage)
        addSubview(movieHomepage)
        
        // Constraints for movieImageView (centered at the top)
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            movieImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 250),
            movieImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // Constraints for movieTitle (below movieImageView)
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            movieTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieOverview (below movieTitle)
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 16),
            movieOverview.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieOverview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieOverview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieTagline (below movieOverview)
        NSLayoutConstraint.activate([
            movieTagline.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 16),
            movieTagline.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieTagline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieTagline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieReleaseDate (left side below movieTagline)
        NSLayoutConstraint.activate([
            movieReleaseDate.topAnchor.constraint(equalTo: movieTagline.bottomAnchor, constant: 16),
            movieReleaseDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieReleaseDate.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        // Constraints for movieVoteAverage (right side next to movieReleaseDate)
        NSLayoutConstraint.activate([
            movieVoteAverage.centerYAnchor.constraint(equalTo: movieReleaseDate.centerYAnchor),
            movieVoteAverage.leadingAnchor.constraint(equalTo: movieReleaseDate.trailingAnchor, constant: 16),
            movieVoteAverage.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
        
        // Constraints for movieHomepage (centered below movieReleaseDate and movieVoteAverage)
        NSLayoutConstraint.activate([
            movieHomepage.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 16),
            movieHomepage.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieHomepage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieHomepage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
