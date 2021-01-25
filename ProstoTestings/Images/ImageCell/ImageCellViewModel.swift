//
//  ImageCellViewModel.swift
//  ProstoTestings
//
//  Created by  Елена on 24.01.2021.
//

import UIKit

protocol ImageCellViewModelProtocol {
    
    var number: Int { get }
    var image : UIImage! { get }
    
}

class ImageCellViewModel: ImageCellViewModelProtocol {
    
    var number : Int
    var image  : UIImage!
    
    required init(item: Item) {
        
        self.number = item.number
        self.image  = item.image
        
    }

}
