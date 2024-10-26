//
//  TableHeaderView.swift
//  TopMovies
//
//  Created by Daniel ST on 25/10/24.
//

import UIKit

class TableHeaderView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Rated Movies"
        label.numberOfLines = 0
        label.font = UIFont(name: "BebasNeue-Regular", size: 55)
        label.textColor = UIColor(named: "FontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupView(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String) {
        titleLabel.text = title
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
