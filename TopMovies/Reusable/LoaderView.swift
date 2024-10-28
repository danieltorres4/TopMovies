//
//  LoaderView.swift
//  TopMovies
//
//  Created by Daniel ST on 27/10/24.
//

import UIKit

final class LoaderView {
    private var title: String?
    private var alert = UIAlertController()
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(alterTitle: String? = nil) {
        title = alterTitle ?? "loadingMessage".localized
        alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        activityIndicator.tintColor = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -10).isActive = true
    }
    
    // MARK: First key window
    func showLoader() {
        if let vc = UIApplication.shared.firstKeyWindow?.rootViewController {
            vc.present(alert, animated: true)
        }
    }
    
    func showModalLoader() {
        if let vc = UIApplication.shared.getTopMostViewController() {
            vc.present(alert, animated: true)
        }
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true)
        }
    }
    
    func editAlertTitle(_ newTitle: String) {
        title = newTitle
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
    
    func getTopMostViewController() -> UIViewController? {
        guard let keyWindow = firstKeyWindow, var topController = keyWindow.rootViewController else {
            return nil
        }
        
        while let presentedController = topController.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
}
