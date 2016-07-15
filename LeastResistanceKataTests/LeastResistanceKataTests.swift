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
        XCTAssertFalse(subject.validateInput(nonNumericInput))
        
        let numericInput = "1 2 3 4 5\n2 3 4 5 6"
        XCTAssertTrue(subject.validateInput(numericInput))
    }
    
    func testValidateInputRequiresAllColumnsToHaveTheSameNumberOfRows() {
        let nonSquareInput = "1 2 3\n1 2 3\n1 2"
        XCTAssertFalse(subject.validateInput(nonSquareInput))
        
        let squareInput = "1 2 3 4 5\n1 2 3 4 5\n1 2 3 4 5"
        XCTAssertTrue(subject.validateInput(squareInput))
    }
    
    func testValidateInputAllowsNegativeIntegers() {
        let negativeInput = "-1 2 3 4 5\n1 2 3 4 5"
        XCTAssertTrue(subject.validateInput(negativeInput))
        
        let weirdNegativeInput = "1-12 3\n1 2 -22"
        XCTAssertFalse(subject.validateInput(weirdNegativeInput))
    }
    
    func testValidateInputRequiresAtLeastOneRow() {
        let notEnoughRows = ""
        XCTAssertFalse(subject.validateInput(notEnoughRows))
        
        let enoughRows = "1 2 3 4 5"
        XCTAssertTrue(subject.validateInput(enoughRows))
    }
    
    func testValidateInputAllowsAtMostTenRows() {
        let tooManyRows = "1 2 3 4 5\n2 2 3 4 5\n3 2 3 4 5\n4 2 3 4 5\n5 2 3 4 5\n6 2 3 4 5\n7 2 3 4 5\n8 2 3 4 5\n9 2 3 4 5\n10 2 3 4 5\n11 2 3 4 5"
        XCTAssertFalse(subject.validateInput(tooManyRows))
        
        let maximumRows = "1 2 3 4 5\n2 2 3 4 5\n3 2 3 4 5\n4 2 3 4 5\n5 2 3 4 5\n6 2 3 4 5\n7 2 3 4 5\n8 2 3 4 5\n9 2 3 4 5\n10 2 3 4 5"
        XCTAssertTrue(subject.validateInput(maximumRows))
    }
    
    func testValidateInputRequiresAtLeastFiveColumns() {
        let notEnoughColumns = "1 2 3 4"
        XCTAssertFalse(subject.validateInput(notEnoughColumns))
        
        let minimumColumns = "1 2 3 4 5"
        XCTAssertTrue(subject.validateInput(minimumColumns))
    }
    
    func testValidateInputAllowsAtMostOneHundredColumns() {
        let tooManyColumns = Array(count:101, repeatedValue:"1").joinWithSeparator(" ")
        XCTAssertFalse(subject.validateInput(tooManyColumns))
        
        let maximumColumns = Array(count:100, repeatedValue:"1").joinWithSeparator(" ")
        XCTAssertTrue(subject.validateInput(maximumColumns))
    }
    
    func testValidateInputConvertsInputIntoAnArrayOfColumns() {
        let validInput = "1 2 3 4 5\n2 3 4 5 6\n3 4 5 6 7"
        subject.validateInput(validInput)
        
        XCTAssertEqual(subject.grid, [[1,2,3],[2,3,4],[3,4,5],[4,5,6],[5,6,7]])
    }
    
    func testCalculateLeastResistanceOutputShouldDisplayAHelpfulMessageIfInputIsInvalid() {
        let invalidInput = "1"
        XCTAssertNotNil(subject.calculateLeastResistance(invalidInput).rangeOfString("Invalid input"))
    }
    
    func testCalculateLeastResistanceOutputShouldIncludeYesToIndicateSuccess() {
        let validGrid = "1 2 3 4 5\n2 3 4 5 6\n3 4 5 6 7"
        XCTAssertNotNil(subject.calculateLeastResistance(validGrid).rangeOfString("Yes"))
    }
    
    func testCalculateLeastResistanceOutputShouldIncludeNoToIndicateFailure() {
        let failingGrid = "50 50 50 50 50\n50 50 50 50 50\n50 50 50 50 50"
        XCTAssertNotNil(subject.calculateLeastResistance(failingGrid).rangeOfString("No"))
    }
    
    func testShortestPathShouldReturnAnArrayIndicatingTheShortestPathThroughTheSpecifiedGrid() {
        let grid = [[1,2,3],[3,1,2],[2,3,1]]
        XCTAssertEqual(subject.shortestPath(grid), [0,1,2])
    }
    
    func testDetermineInputLocationsShouldReturnAnArrayOfOrderedLocationsAndAnArrayOfCorrespondingValues() {
        let grid = [[1,2,3,4],[1,2,3,4]]
        XCTAssertEqual(subject.determineInputLocations(grid, column: 1, row: 0)!, [[0,1,3], [1,2,4]])
    }

    func testNormalizeIndexShouldReturnAnIndexThatExistsWithinTheSpecifiedArray() {
        XCTAssertEqual(subject.normalizeIndex(12, range:3), 0)
    }
    
    func testShortestPathThroughShouldReturnTheSumOfTheLeastValueInTheInputArrayAndTheSpecifiedValue() {
        XCTAssertEqual(subject.shortestPathThrough([1,2,3], inputLocations: [0, 1, 2], currentValue: 1), [2, 0])
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
        XCTAssertEqual(subject.calculateRoute(grid, pathGrid: pathGrid), [0, 0, 1])
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
        
        XCTAssertEqual(subject.analyzePath(path, grid:successGrid), "Yes\n3\n1 1 1")
        XCTAssertEqual(subject.analyzePath(path, grid:failureGrid), "No\n45\n1")
    }
    
    func testNormalizePathShouldTurnAZeroBasedPathIntoAOneBasedPathAndTruncateToSpecifiedLength() {
        let path = [0, 1, 3]
        XCTAssertEqual( subject.normalizePath(path, length: 2), "1 2")
    }
    
    func testValidateDemonstrationGrids() {
        let testGrid = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        XCTAssertEqual(subject.calculateLeastResistance(testGrid), "Yes\n16\n1 2 3 4 4 5")

        let testGrid2 = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3"
        XCTAssertEqual(subject.calculateLeastResistance(testGrid2), "Yes\n11\n1 2 1 5 4 5")
        
        let failGrid = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        XCTAssertEqual(subject.calculateLeastResistance(failGrid), "No\n48\n1 1 1")
    }
}
