//
//  ImageCellViewModel.swift
//  ProstoTestings
//
//  Created by  Елена on 24.01.2021.
//

import UIKit

protocol ImageCellViewModelProtocol {
    
    var number: Int { get }
    init(number: Int)
    func downloadImage(completion: @escaping (Result<UIImage, NetworkRequestError>) -> Void)
    
}

class ImageCellViewModel: ImageCellViewModelProtocol {
    
    var number : Int
    
    required init(number: Int) {
        
        self.number = number
        
    }
    
    func downloadImage(completion: @escaping (Result<UIImage, NetworkRequestError>) -> Void) {
       
        let imageLoader = ImageLoader(for: number)
        imageLoader.getImage(completion: completion)
        
    }
}
