//
//  MovieDetailView.swift
//  TopMovies
//
//  Created by Daniel ST on 24/10/24.
//

import UIKit

class MovieDetailView: UIView {
    var movieHomepageURL: URL?
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return iv
    }()
    let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "BebasNeue-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 15)
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
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Italic", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieHomepage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Italic", size: 15)
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        let homepageGesture = UITapGestureRecognizer(target: self, action: #selector(openHomepage))
        movieHomepage.addGestureRecognizer(homepageGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let releaseDateAndVoteSV = UIStackView(arrangedSubviews: [movieReleaseDate, movieVoteAverage])
        releaseDateAndVoteSV.axis = .horizontal
        releaseDateAndVoteSV.spacing = 16
        releaseDateAndVoteSV.alignment = .fill
        releaseDateAndVoteSV.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [movieImageView, movieTitle, movieTagline, movieOverview, releaseDateAndVoteSV, movieHomepage])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            movieOverview.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            movieOverview.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            movieHomepage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            movieHomepage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    @objc func openHomepage() {
        guard let url = movieHomepageURL else { return }
        UIApplication.shared.open(url)
    }
    
    func configureView(with movieHomepageText: String, homepageURL: URL?) {
        movieHomepage.text = movieHomepageText
        movieHomepageURL = homepageURL
    }

}
