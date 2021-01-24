//
//  ImagesViewModel.swift
//  ProstoTestings
//
//  Created by  Елена on 24.01.2021.
//

import Foundation
import UIKit

//MARK:- ImagesViewModelProtocol:
protocol ImagesViewModelProtocol {
    
    var imageObjects : [Item] { get }
    var numberOfRows : Int { get }
    var lastRowIndex : Int { get }
    var startIndex : Int { get set }
    var endIndex : Int { get set }
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol?
    
}

//MARK:- ImagesViewModel:
class ImagesViewModel : ImagesViewModelProtocol {
    
    private var array = [Int]()
    
    var imageObjects = [Item]()
    
    var startIndex = 0 {
        didSet {
            updateArray()
            updateImageObjects()
        }
    }
    var endIndex = 20 {
        didSet {
            updateArray()
            updateImageObjects()
        }
    }
    
    var numberOfRows : Int {
        array.count
    }
    var lastRowIndex : Int {
        array.count - 1
    }
    
    func updateArray() {
        array = Array(startIndex ..< endIndex)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol? {
        
        let number = array[indexPath.row] + 1
        return ImageCellViewModel(number: number)
        
    }
    
    init() {
        array = Array(0..<20)
        updateImageObjects()
    }
    
    func updateImageObjects() {
        
        // Get our image URLs for processing.
        if imageObjects.isEmpty {
            for number in array {
                if let url = URL(string:"https://via.placeholder.com/150/000000/FFFFFF/?text=\(number)") {
                    self.imageObjects.append(Item(image: UIImage(systemName: "rectangle")!, url: url))
                }
            }
        }
        
    }
    
}

