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
    
    var array : [ Int] { get }
    var firstNumber : Int { get }
    var firstFiveNumbers : [ Int] { get }
    var numberOfRows : Int { get }
    var lastRowIndex : Int { get }
    var startIndex : Int { get set }
    var endIndex : Int { get set }
    var lastNumber : Int { get }
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol?
    
}

//MARK:- ImagesViewModel:
class ImagesViewModel : ImagesViewModelProtocol {
    
    var array = [Int]()
    
    var startIndex = 0 {
        didSet {
            updateArray()
        }
    }
    var endIndex = 20 {
        didSet {
            updateArray()
        }
    }
    
    var firstNumber : Int {
        array.first!
    }
    var firstFiveNumbers : [Int] {
        let firstFive = Array(array.prefix(5))
        return firstFive
    }
    
    var numberOfRows : Int {
        array.count
    }
    var lastRowIndex : Int {
        array.count - 1
    }
    var lastNumber : Int {
        array.last!
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
    }
    
}

