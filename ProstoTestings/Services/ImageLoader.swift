//
//  ImageLoader.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    var imageCache = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
    
    func getImage(for number: Int, completion: @escaping (Result<UIImage, NetworkRequestError>) -> Void) {
        
        let urlString = "https://via.placeholder.com/150/000000/FFFFFF/?text=\(number)"
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            
            completion(.success(imageFromCache))
            
        } else {
            
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
                
                guard let self = self else {
                    return
                }

                if let error = error {
                    /// No Internet Connection
                    if error._code == NSURLErrorNotConnectedToInternet {
                        DispatchQueue.main.async {
                            completion(.failure(.offline))
                        }
                        /// Другая ошибка
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(.error(description: error.localizedDescription)))
                        }
                    }
                    
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return
                }
                guard let data = data else {
                    return
                }
                
                guard let imageToCache = UIImage(data: data) else {
                    return
                }
                
                self.imageCache.setObject(imageToCache, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    completion(.success(imageToCache))
                }
                
            }.resume()
        }
    }
    
}

