//
//  LeastResistanceKataTests.swift
//  LeastResistanceKataTests
//
//  Created by Jeremy Winters on 7/5/16.
//  Copyright © 2016 Jeremy Winters. All rights reserved.
//

import XCTest
@testable import LeastResistanceKata

class LeastResistanceKataTests: XCTestCase {
    
    let subject = LeastResistanceCalculator()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidateInputAcceptsOnlyNumbers() {
        let non_numeric_input = "asdf"
        XCTAssert(subject.validateInput(non_numeric_input) == false)
        
        let numeric_input = "1\n2\n3\n4\n5"
        XCTAssert(subject.validateInput(numeric_input) == true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}
