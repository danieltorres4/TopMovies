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
        setBackgroundColor()
        setupViews()
        getTopRatedMovies(page: 1)
    }

    func getTopRatedMovies(page: Int, pagination: Bool = false) {
        presenter.onViewAppear(page: page, pagination: pagination)
    }
    
    func setBackgroundColor() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        topRatedMoviesTV.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    private func setupViews() {
        view.addSubview(topRatedMoviesTV)
        
        NSLayoutConstraint.activate([
            topRatedMoviesTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topRatedMoviesTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topRatedMoviesTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topRatedMoviesTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
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
        let movie = movieViewModel(for: indexPath.row)
        presenter.selectedMovie(with: indexPath.row, movie: movie)
        topRatedMoviesTV.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = presenter.movieViewModels.count - 1
        if indexPath.row == lastItem && presenter.currentPage < presenter.totalPages {
            // Request more info
            getTopRatedMovies(page: presenter.currentPage + 1, pagination: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView(title: "topRatedMoviesTitle".localized)
        headerView.backgroundColor = UIColor(named: "BackgroundColor")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension MainViewController: TopRatedMoviesUI {
    func update(with movies: [MovieViewModel]) {
        self.topRatedMovies.append(contentsOf: movies)
        debugPrint("Received data: \(movies)")
        DispatchQueue.main.async {
            self.topRatedMoviesTV.reloadData()
        }
    }
    
    func showLoaderView(loaderView: LoaderView?) {
        guard let loaderView = loaderView else { return }
        DispatchQueue.main.async {
            loaderView.showLoader()
        }
    }
    func hideLoaderView(loaderView: LoaderView?) {
        guard let loaderView = loaderView else { return }
        DispatchQueue.main.async {
            loaderView.removeLoader()
        }
    }
}

extension MainViewController {
    func movieViewModel(for index: Int) -> MovieViewModel {
        let movie = presenter.movieViewModels[index]
        return MovieViewModel(id: movie.id, title: movie.title, posterPath: movie.posterPath, releaseDate: movie.releaseDate, overview: movie.overview, voteAverage: movie.voteAverage)
    }
}
