//
//  MainPresenter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation

protocol TopRatedMoviesUI: AnyObject {
    func update(with movies: [Movie])
}

class MainPresenter {
    var ui: TopRatedMoviesUI?
    private let mainInteractor: MainInteractor
    var models: [Movie] = []
    
    init(mainInteractor: MainInteractor) {
        self.mainInteractor = mainInteractor
    }
    
    func onViewAppear() {
        Task {
            models = await mainInteractor.getListOfMovies().results
            ui?.update(with: models)
        }
    }
}
