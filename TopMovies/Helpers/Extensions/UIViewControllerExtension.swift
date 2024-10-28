//
//  UIViewControllerExtension.swift
//  TopMovies
//
//  Created by Daniel ST on 28/10/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertOneAction(title: String, message: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "acceptAction".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
