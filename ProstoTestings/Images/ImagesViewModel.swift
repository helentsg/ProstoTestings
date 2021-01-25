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
    
    var items : [ Item] { get }
    var firstItem : Item { get }
    var firstFiveItems : [Item] { get }
    var numberOfRows : Int { get }
    var lastRowIndex : Int { get }
    var startIndex : Int { get set }
    var endIndex : Int { get set }
    var lastItem : Item { get }
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol?
    func itemForNumber(_ number: Int) -> Item?
    
}

//MARK:- ImagesViewModel:
class ImagesViewModel : ImagesViewModelProtocol {
    
    var items = [Item]()
    private(set) var array = [Int]()
    
    var startIndex = 0 {
        didSet {
            updateArray()
            addNewFirstFiveToItems()
        }
    }
    var endIndex = 20 {
        didSet {
            updateArray()
            addNewLastItemToItems()
        }
    }
    
    var firstItem : Item {
        items.first!
    }
    
    var firstFiveItems : [Item] {
        let firstFive = Array(items.prefix(5))
        return firstFive
    }
    
    var numberOfRows : Int {
        array.count
    }
    var lastRowIndex : Int {
        array.count - 1
    }
    var lastItem : Item {
        items.last!
    }
    
    init() {
        
        array = Array(0..<20)
        items = array.map({Item(number: $0)})
        
    }
}

//MARK:- Methods:
extension ImagesViewModel {
    
    func updateArray() {
        array = Array(startIndex ..< endIndex)
    }
    
    func addNewFirstFiveToItems() {
        let firstFiveNumbers = Array(array.prefix(5))
        let five = firstFiveNumbers.map({ Item(number: $0) })
        items.insert(contentsOf: five, at: 0)
    }
    
    func addNewLastItemToItems() {
        let item = Item(number: array.last!)
        items.append(item)
    }
    
    func itemForNumber(_ number: Int) -> Item? {
        let item = items.filter({ $0.number == number }).first
        return item
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol? {
        
        let number = array[indexPath.row]
        if let item = items.filter({ $0.number == number }).first {
            return ImageCellViewModel(item: item)
        } else {
            return nil
        }
        
    }
    
}

