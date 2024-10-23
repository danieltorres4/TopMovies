//
//  MainRouter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

class MainRouter {
    // Component connection
    func showTopRatedMovies(window: UIWindow?) {
        let interactor = MainInteractor()
        let presenter = MainPresenter(mainInteractor: interactor)
        let viewController = MainViewController(presenter: presenter)
        presenter.ui = viewController
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
