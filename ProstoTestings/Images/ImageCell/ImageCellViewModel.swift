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
    var imageLoader : ImageLoader! { get }
    
}

class ImageCellViewModel: ImageCellViewModelProtocol {
    
    var number : Int
    var imageLoader : ImageLoader!
    
    required init(number: Int) {
        
        self.number = number
        imageLoader = ImageLoader.shared
        
    }

}
