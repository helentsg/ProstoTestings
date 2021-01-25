//
//  ItemTests.swift
//  ProstoTestingsTests
//
//  Created by  Елена on 25.01.2021.
//

import XCTest
@testable import ProstoTestings

class ItemTests: XCTestCase {

    var sut : Item!
    
    override func setUp() {
        super.setUp()
        sut = Item(number: 4)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitItemWithNumberAndImage() {
        
        XCTAssertNotNil(sut)
        
    }
    
    func testIsURLSetupCorrectly() {
        
        let url = URL(string: "https://via.placeholder.com/150/000000/FFFFFF/?text=\(4)")!
        XCTAssertEqual(url, sut.url)
        
    }
    
}
