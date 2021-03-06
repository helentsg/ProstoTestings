//
//  Item.swift
//  ProstoTestings
//
//  Created by  Елена on 25.01.2021.
//

import UIKit

class Item: Hashable {
    
    let number: Int!
    let url: URL!
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(number: Int) {
        self.number = number
        self.url = URL(string: "https://via.placeholder.com/150/000000/FFFFFF/?text=\(number)")!
    }

}

