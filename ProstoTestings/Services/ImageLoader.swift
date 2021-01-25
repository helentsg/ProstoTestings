//
//  ImageLoader.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    var cachedImages = NSCache<NSURL, UIImage>()
    
    final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    private init() {
        
    }
    
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    func downloadImage(withURL url: URL, forCell cell: UITableViewCell, completion: @escaping (Result<(UITableViewCell, UIImage?), NetworkRequestError>) -> Void) {
        
        let url = url as NSURL
        
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(.success((cell, cachedImage)))
            }
            return
        }
        
        // Go fetch the image.
        let request = URLRequest(url: url as URL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                                /// No Internet Connection
                                if error._code == NSURLErrorNotConnectedToInternet {
                                    DispatchQueue.main.async {
                                        completion(.failure(.offline))
                                        return
                                    }
                                    /// Другая ошибка
                                } else {
                                    DispatchQueue.main.async {
                                        completion(.failure(.error(description: error.localizedDescription)))
                                        return
                                    }
                                }
                            }

            guard let responseData = data,
                  let image = UIImage(data: responseData),
                  error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.error(description: "Ошибка загрузки")))
                }
                return
            }
            
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url)
            
            DispatchQueue.main.async {
                completion(.success((cell, image)))
            }
            
        }.resume()
    }
    
}

