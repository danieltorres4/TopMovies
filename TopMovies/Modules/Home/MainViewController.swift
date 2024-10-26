//
//  ViewController.swift
//  TopMovies
//
//  Created by Daniel ST on 22/10/24.
//

import UIKit

class MainViewController: UIViewController {
    var topRatedMovies: [MovieViewModel] = []
    private var topRatedMoviesTV: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 120
        tv.rowHeight = UITableView.automaticDimension
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        return tv
    }()
    private let presenter: TopRatedMoviesPresenter
    
    init(presenter: TopRatedMoviesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        debugPrint("ViewDidLoad")
        setupViews()
        getTopRatedMovies(page: 1)
    }

    func getTopRatedMovies(page: Int) {
        presenter.onViewAppear(page: page, pagination: false)
    }
    
    private func setupViews() {
        view.addSubview(topRatedMoviesTV)
        
        NSLayoutConstraint.activate([
            topRatedMoviesTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topRatedMoviesTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topRatedMoviesTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topRatedMoviesTV.topAnchor.constraint(equalTo: view.topAnchor) // view.safeAreaLayoutGuide.topAnchor
        ])
        
        topRatedMoviesTV.dataSource = self
        topRatedMoviesTV.delegate = self
    }

}

// MARK: Table View Methods
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        let model = presenter.movieViewModels[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedMovie(with: indexPath.row, movie: MovieViewModel(title: presenter.movieViewModels[indexPath.row].title, posterPath: presenter.movieViewModels[indexPath.row].posterPath, releaseDate: presenter.movieViewModels[indexPath.row].releaseDate, overview: presenter.movieViewModels[indexPath.row].overview, voteAverage: presenter.movieViewModels[indexPath.row].voteAverage))
        topRatedMoviesTV.deselectRow(at: indexPath, animated: true)
    }
    
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = presenter.movieViewModels.count - 1
        if indexPath.row == lastItem && presenter.currentPage < presenter.totalPages {
            // Request more info
            debugPrint("Reached the end of the list...")
            // getTopRatedMovies(page: presenter.currentPage + 1)
        }
    }*/
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView(title: "topRatedMoviesTitle".localized)
        headerView.backgroundColor = UIColor(named: "BackgroundColor")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (topRatedMoviesTV.contentSize.height - 100 - scrollView.frame.size.height) {
            // Fetch more data
            debugPrint("Fetch more...")
            presenter.onViewAppear(page: presenter.currentPage + 1, pagination: true)
        }
    }
}

extension MainViewController: TopRatedMoviesUI {
    func update(with movies: [MovieViewModel]) {
        for movie in movies {
            topRatedMovies.append(movie)
        }
        debugPrint("Received data: \(movies)")
        DispatchQueue.main.async {
            self.topRatedMoviesTV.reloadData()
        }
    }
}
