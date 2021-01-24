//
//  ProstoTestingsTests.swift
//  ProstoTestingsTests
//
//  Created by  Елена on 24.01.2021.
//

import XCTest
@testable import ProstoTestings

class ProstoTestingsTests: XCTestCase {

    var sut : ImagesViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ImagesViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testArrayShouldNotBeEmpty() {
        sut.updateArray()
        let array = sut.array
        XCTAssert(!array.isEmpty, "Numbers Array should not be empty")
    }

}
