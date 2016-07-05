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
        let nonNumericInput = "asdf"
        XCTAssert(subject.validateInput(nonNumericInput) == false)
        
        let numericInput = "1\n2\n3\n4\n5"
        XCTAssert(subject.validateInput(numericInput) == true)
    }
    
    func testValidateInputRequiresAllColumnsToHaveTheSameNumberOfRows() {
        let nonSquareInput = "1 2 3\n1 2 3\n1 2"
        XCTAssert(subject.validateInput(nonSquareInput) == false)
        
        let squareInput = "1 2 3\n1 2 3\n1 2 3"
        XCTAssert(subject.validateInput(squareInput) == true)
    }
    
    func testValidateInputAllowsNegativeIntegers() {
        let negativeInput = "-1 2 3\n1 2 3"
        XCTAssert(subject.validateInput(negativeInput) == true)
        
        let weirdNegativeInput = "1-12 3\n1 2 -22"
        XCTAssert(subject.validateInput(weirdNegativeInput) == false)
    }
}
