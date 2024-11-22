//
//  UIImageViewExtensions.swift
//  TopMovies
//
//  Created by Daniel ST on 23/10/24.
//

import Foundation
import UIKit

extension UIImageView {
    private static var currentURL: [UIImageView: URL] = [:]
    
    func loadFrom(from URLAddress: String, contentMode mode: ContentMode = .scaleAspectFit, placeholder: UIImage? = nil, completion: ((Bool) -> Void)? = nil) {
        self.contentMode = mode
        self.image = placeholder
        
        guard let url = URL(string: URLAddress) else {
            debugPrint("Invalid URL: \(URLAddress)")
            completion?(false)
            return
        }
        
        // Assigning current URL and checking if it already exists in cache
        UIImageView.currentURL[self] = url
        if let cachedImage = ImageCache.shared.object(forKey: URLAddress as NSString) {
            self.image = cachedImage
            completion?(true)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // Verifying if the URL is the same
            if UIImageView.currentURL[self] != url {
                completion?(false)
                return
            }
            
            if let error = error {
                debugPrint("Error loading image: \(error.localizedDescription)")
                completion?(false)
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                debugPrint("Invalid image data")
                completion?(false)
                return
            }
            
            // Caching
            ImageCache.shared.setObject(image, forKey: URLAddress as NSString)
            
            DispatchQueue.main.async {
                self.image = image
                completion?(true)
            }
        }.resume()
    }
}
