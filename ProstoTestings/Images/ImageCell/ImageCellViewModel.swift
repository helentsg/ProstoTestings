//
//  ImageCellViewModel.swift
//  ProstoTestings
//
//  Created by  Елена on 24.01.2021.
//

import UIKit

protocol ImageCellViewModelProtocol {
    
    var number: Int { get }
    var url  : URL { get }
    func downloadImage(withURL url: URL, forCell cell: UITableViewCell, completion: @escaping (Result<(UITableViewCell, UIImage?), NetworkRequestError>) -> Void)
    
}

class ImageCellViewModel: ImageCellViewModelProtocol {
    
    var number : Int
    var url  : URL
    
    required init(item: Item) {
        
        self.number = item.number
        self.url = item.url
        
    }

}

//MARK:- Methods:
extension ImageCellViewModel {

    func downloadImage(withURL url: URL, forCell cell: UITableViewCell, completion: @escaping (Result<(UITableViewCell, UIImage?), NetworkRequestError>) -> Void) {
        cell.tag = number
        ImageLoader.shared.downloadImage(withURL: url, forCell: cell, completion: completion)
        
    }
    
}


