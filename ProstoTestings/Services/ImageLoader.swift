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
    private var loadingResponses = [NSURL: [(Result<(Item, UIImage?), NetworkRequestError>) -> Void]]()
    
    final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    private init() {
        
    }
    
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    func downloadImage(withURL url: URL, forItem item: Item, completion: @escaping (Result<(Item, UIImage?), NetworkRequestError>) -> Void) {
        
        let url = url as NSURL
        
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(.success((item, cachedImage)))
            }
            return
        }
        
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        // Go fetch the image.
        ImageURLProtocol.urlSession().dataTask(with: url as URL) {[weak self] (data, response, error) in
            
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
                  let blocks = self.loadingResponses[url],
                  error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.error(description: "Ошибка загрузки")))
                }
                return
            }
            
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url)
            
            for block in blocks {
                DispatchQueue.main.async {
                    block(.success((item, image)))
                }
                return
            }
            
        }.resume()
    }
    
}

