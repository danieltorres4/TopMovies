//
//  MainRouter.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

class MainRouter {
    func showTopRatedMovies(window: UIWindow?) {
        let viewController = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter(mainInteractor: interactor)
        presenter.ui = viewController
        viewController.presenter = presenter
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
