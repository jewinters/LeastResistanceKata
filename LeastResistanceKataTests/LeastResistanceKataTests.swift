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
        
        let numericInput = "1 2 3 4 5\n2 3 4 5 6"
        XCTAssert(subject.validateInput(numericInput) == true)
    }
    
    func testValidateInputRequiresAllColumnsToHaveTheSameNumberOfRows() {
        let nonSquareInput = "1 2 3\n1 2 3\n1 2"
        XCTAssert(subject.validateInput(nonSquareInput) == false)
        
        let squareInput = "1 2 3 4 5\n1 2 3 4 5\n1 2 3 4 5"
        XCTAssert(subject.validateInput(squareInput) == true)
    }
    
    func testValidateInputAllowsNegativeIntegers() {
        let negativeInput = "-1 2 3 4 5\n1 2 3 4 5"
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
    
    func testValidateInputRequiresAtLeastFiveColumns() {
        let notEnoughColumns = "1 2 3 4"
        XCTAssert(subject.validateInput(notEnoughColumns) == false)
    }
    
    func testValidateInputAllowsAtMostOneHundredColumns() {
        let tooManyColumns = Array(count:101, repeatedValue:"1").joinWithSeparator(" ")
        XCTAssert(subject.validateInput(tooManyColumns) == false)
    }
    
    func testValidateInputConvertsInputIntoAnArrayOfColumns() {
        let validInput = "1 2 3 4 5\n2 3 4 5 6\n3 4 5 6 7"
        subject.validateInput(validInput)
        
        XCTAssert(subject.grid == [[1,2,3],[2,3,4],[3,4,5],[4,5,6],[5,6,7]])
    }
    
    func testCalculateLeastResistanceOutputShouldDisplayAHelpfulMessageIfInputIsInvalid() {
        let invalidInput = "1"
        XCTAssert(subject.calculateLeastResistance(invalidInput).rangeOfString("Invalid input") != nil)
    }
    
    func testCalculateLeastResistanceOutputShouldIncludeYesToIndicateSuccess() {
        let validGrid = "1 2 3 4 5\n2 3 4 5 6\n3 4 5 6 7"
        XCTAssert(subject.calculateLeastResistance(validGrid).rangeOfString("Yes") != nil)
    }
    
    func testCalculateLeastResistanceOutputShouldIncludeNoToIndicateFailure() {
        let failingGrid = "50 50 50 50 50\n50 50 50 50 50\n50 50 50 50 50"
        XCTAssert(subject.calculateLeastResistance(failingGrid).rangeOfString("No") != nil)
    }
    
    func testShortestPathShouldReturnAnArrayIndicatingTheShortestPathThroughTheSpecifiedGrid() {
        let grid = [[1,2,3],[3,1,2],[2,3,1]]
        XCTAssert(subject.shortestPath(grid) == [0,1,2])
    }
    
    func testDetermineInputLocationsShouldReturnAnArrayOfOrderedLocationsAndAnArrayOfCorrespondingValues() {
        let grid = [[1,2,3,4],[1,2,3,4]]
        XCTAssert( subject.determineInputLocations(grid, column: 1, row: 0)! == [[0,1,3], [1,2,4]] )
    }

    func testNormalizeIndexShouldReturnAnIndexThatExistsWithinTheSpecifiedArray() {
        XCTAssert( subject.normalizeIndex(12, range:3) == 0 )
    }
    
    func testShortestPathThroughShouldReturnTheSumOfTheLeastValueInTheInputArrayAndTheSpecifiedValue() {
        XCTAssert( subject.shortestPathThrough([1,2,3], inputLocations: [0, 1, 2], currentValue: 1) == [2, 0] )
    }
    
    func testCalculateRouteShouldReturnARouteThroughTheGridAccordingToThePathSpecified() {
        let grid = [
            [1, 1, 1],
            [2, 2, 2],
            [4, 3, 4]
        ]
        let pathGrid = [
            [0, 0, 0],
            [0, 0, 0]
        ]
        XCTAssert( subject.calculateRoute(grid, pathGrid: pathGrid) == [0, 0, 1] )
    }
    
    func testAnalyzePathWillAnalyzeAPathThroughAGridAndReturnATextualAnalysis() {
        let path = [0, 0, 0]
        let successGrid = [
            [1, 1, 1],
            [1, 1, 1],
            [1, 1, 1]
        ]
        let failureGrid = [
            [45, 45, 45],
            [45, 45, 45],
            [45, 45, 45]
        ]
        
        XCTAssert( subject.analyzePath(path, grid:successGrid) == "Yes\n3\n1 1 1")
        XCTAssert( subject.analyzePath(path, grid:failureGrid) == "No\n45\n1")
    }
    
    func testNormalizePathShouldTurnAZeroBasedPathIntoAOneBasedPathAndTruncateToSpecifiedLength() {
        let path = [0, 1, 3]
        XCTAssert( subject.normalizePath(path, length: 2) == "1 2" )
    }
    
    func testValidateDemonstrationGrids() {
        let testGrid = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        XCTAssert( subject.calculateLeastResistance(testGrid) == "Yes\n16\n1 2 3 4 4 5" )

        let testGrid2 = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3"
        XCTAssert( subject.calculateLeastResistance(testGrid2) == "Yes\n11\n1 2 1 5 4 5" )
        
        let failGrid = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        XCTAssert( subject.calculateLeastResistance(failGrid) == "No\n48\n1 1 1" )
    }
}
