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
    
    func getImage(completion: @escaping ((UIImage?) -> Void)) {
        
        let imageCache = NSCache<NSString, UIImage>()
        guard let url = URL(string: urlString) else {
            return
        }
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            completion(imageFromCache)
        } else {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                if let error = error {
                    print("failed to get data from url \(error)" )
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        return
                }
                guard let data = data else {
                    return
                }
                
                let imageToCache = UIImage(data: data) ?? UIImage(systemName: "multiply")!
                
                imageCache.setObject(imageToCache, forKey: self.urlString as NSString)
                    DispatchQueue.main.async {
                    completion(imageToCache)
                }
            }.resume()
        }
    }
    
}

