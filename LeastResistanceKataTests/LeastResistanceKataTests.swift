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
    
    func testValidateInputRequiresAtLeastOneRow() {
        let notEnoughRows = ""
        XCTAssert(subject.validateInput(notEnoughRows) == false)
    }
    
    func testValidateInputAllowsAtMostTenRows() {
        let tooManyRows = "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11"
        XCTAssert(subject.validateInput(tooManyRows) == false)
    }
    
    func testValidateInputRequiresAtLeastOneColumn() {
        let notEnoughColumns = "\n"
        XCTAssert(subject.validateInput(notEnoughColumns) == false)
    }
    
    func testValidateInputAllowsAtMostOneHundredColumns() {
        let tooManyColumns = Array(count:101, repeatedValue:"1").joinWithSeparator(" ")
        XCTAssert(subject.validateInput(tooManyColumns) == false)
    }
    
    func testValidateInputConvertsInputIntoAnArrayOfColumns() {
        let validInput = "1 2 3\n4 5 6\n7 8 9"
        subject.validateInput(validInput)
        
        XCTAssert(subject.grid == [[1,4,7],[2,5,8],[3,6,9]])
    }
}
