//
//  ImageLoader.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImageLoader {
    
    let urlString : String
    
    init(for number: Int ) {
        self.urlString = "https://via.placeholder.com/150/000000/FFFFFF/?text=\(number)"
    }
    
    func getImage(completion: @escaping (Result<UIImage, NetworkRequestError>) -> Void) {
        
        let imageCache = NSCache<NSString, UIImage>()
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            
            completion(.success(imageFromCache))
            
        } else {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                DispatchQueue.main.async {
                    if let error = error {
                        /// No Internet Connection
                        if error._code == NSURLErrorNotConnectedToInternet {
                            completion(.failure(.offline))
                            /// Другая ошибка
                        } else {
                            completion(.failure(.error(description: error.localizedDescription)))
                        }
                        
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    
                    if let imageToCache = UIImage(data: data) {
                        imageCache.setObject(imageToCache, forKey: self.urlString as NSString)
                        completion(.success(imageToCache))
                        
                    } else {
                        completion(.failure(.error(description: "Ошибка загрузки")))
                    }
                }
                
            }.resume()
        }
    }
    
}

