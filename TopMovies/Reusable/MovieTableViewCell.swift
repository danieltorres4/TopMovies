//
//  MovieTableViewCell.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2.0
        iv.layer.borderColor = UIColor(named: "AccentedColor")?.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "BebasNeue-Regular", size: 32) // .systemFont(ofSize: 32, weight: .bold, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 20) // .systemFont(ofSize: 12, weight: .regular, width: .standard)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(movieImageView)
        addSubview(movieName)
        addSubview(movieReleaseDateLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
            
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 18),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            movieName.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 24),
            
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            movieReleaseDateLabel.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 8),
            movieReleaseDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configureCell(model: MovieViewModel) {
        movieName.text = model.title
        movieReleaseDateLabel.text = model.releaseDate
        movieImageView.loadFrom(from: model.posterPath)
    }

    

}