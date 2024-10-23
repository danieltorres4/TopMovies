//
//  ViewController.swift
//  TopMovies
//
//  Created by Daniel ST on 22/10/24.
//

import UIKit

class MainViewController: UIViewController {
    private var topRatedMoviesTV: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 120
        tv.rowHeight = UITableView.automaticDimension
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        return tv
    }()
    var presenter: MainPresenter?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        debugPrint("Home VC")
        setupViews()
        getTopRatedMovies()
    }

    func getTopRatedMovies() {
        presenter?.onViewAppear()
    }
    
    private func setupViews() {
        view.addSubview(topRatedMoviesTV)
        
        NSLayoutConstraint.activate([
            topRatedMoviesTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topRatedMoviesTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topRatedMoviesTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topRatedMoviesTV.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        topRatedMoviesTV.dataSource = self
    }

}

// MARK: Table View Methods
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter!.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        let model = presenter!.models[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
}

extension MainViewController: TopRatedMoviesUI {
    func update(with movies: [Movie]) {
        debugPrint("Received data: \(movies)")
        DispatchQueue.main.async {
            self.topRatedMoviesTV.reloadData()
        }
    }
}
