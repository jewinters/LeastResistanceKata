//
//  LeastResistanceCalculator.swift
//  LeastResistanceKata
//
//  Created by Jeremy Winters on 7/5/16.
//  Copyright © 2016 Jeremy Winters. All rights reserved.
//

import Foundation

class LeastResistanceCalculator {
    
    var grid:[[Int]] = []
    
    func validateInput(input:String) -> Bool {
        //reinitialize grid
        grid = []
        
        do {
            //Numeric
            let regex = try NSRegularExpression(pattern: "^(-?\\d+\\s)*(-?\\d+)$", options: NSRegularExpressionOptions.CaseInsensitive)
            let matches = regex.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count))
            if matches.count == 0 {
                return false
            }
            
            let rowArray = input.characters.split{$0 == "\n"}.map(String.init)
            //Too few rows
            if rowArray.count == 0 {
                return false
            }
            //Too many rows
            if rowArray.count > 10 {
                return false
            }
            let rowSize = rowArray[0].characters.split{$0 == " "}.map(String.init).count
            //Too few columns
            if rowSize < 5 {
                return false
            }
            
            //Too many columns
            if rowSize > 100 {
                return false
            }
            
            for row in rowArray {
                let intArray = row.characters.split{$0 == " "}.map(String.init).map{ Int($0)! }
                //Non-rectangular
                if rowSize != intArray.count {
                    return false
                }
                
                //Build grid as an array of columns
                for (index, value) in intArray.enumerate() {
                    if grid.indices.contains(index) {
                        grid[index].append( value )
                    } else {
                        grid.append( [value] )
                    }
                }
            }

            return true
            
        } catch {
            return false
        }
    }
    
    func calculateLeastResistance(input:String) -> String {
        if !validateInput(input) || grid.count == 0 {
            return "Invalid input: please enter a grid of 1 to 10 rows and 5 to 100 columns of integers delimited by spaces.\nExample:\n1 2 3 4 5\n6 7 8 9 10\n-11 12 13 14 15"
        }
        
        let path = shortestPath(grid)
        return analyzePath(path, grid: grid)
    }
    
    func shortestPath(grid:[[Int]]) -> [Int] {
        var superGrid:[[Int]] = []
        var pathGrid: [[Int]] = []
        for (columnIndex, column) in grid.enumerate() {
            var superGridRow:[Int] = []
            var pathGridRow: [Int] = []
            for (rowIndex, node) in column.enumerate() {
                let inputs = determineInputLocations(superGrid, column: columnIndex, row: rowIndex)!
                let inputLocations = inputs[0]
                let inputValues = inputs[1]
                let shortestPathThroughNode = shortestPathThrough(inputValues, inputLocations:inputLocations, currentValue: node)
                superGridRow.append(shortestPathThroughNode[0])
                pathGridRow.append(shortestPathThroughNode[1])
            }
            superGrid.append(superGridRow)
            if superGrid.count > 1 {
                pathGrid.append(pathGridRow)
            }
        }
        
        return calculateRoute(superGrid, pathGrid:pathGrid)
    }
    
    func determineInputLocations( grid:[[Int]], column:Int, row:Int ) -> [[Int]]? {
        if column == 0 {
            return [[0,0,0], [0,0,0]]
        }
        if grid.count < column {
            return [[0,0,0], [0,0,0]]
        }
        if grid[column-1].count <= row {
            return [[0,0,0], [0,0,0]]
        }
        
        let array = grid[column-1]
        
        let upperLeft = normalizeIndex(row - 1, range:array.count)
        let middleLeft = normalizeIndex(row, range:array.count)
        let lowerLeft = normalizeIndex(row + 1, range:array.count)
        
        let locations = [upperLeft, middleLeft, lowerLeft].sort()
        let values = [array[locations[0]], array[locations[1]], array[locations[2]]]
        
        return [locations, values]
    }

    func normalizeIndex(index:Int, range:Int) -> Int {
        if index < 0 {
            return normalizeIndex(index + range, range: range)
        }
        if index >= range {
            return normalizeIndex(index - range, range: range)
        }
        return index
    }

    func shortestPathThrough( inputValues:[Int], inputLocations:[Int], currentValue:Int ) -> [Int] {
        let minValue = inputValues.minElement()!
        let minIndex = inputValues.indexOf(minValue)!
        return [minValue + currentValue, inputLocations[minIndex]]
    }

    func calculateRoute(superGrid:[[Int]], pathGrid:[[Int]]) -> [Int] {
        var path:[Int] = []
        
        let endNode = superGrid[superGrid.count-1].minElement()!
        let endIndex = superGrid[superGrid.count-1].indexOf(endNode)!
        
        path.append(endIndex)
        
        //Walk backwards through the path grid
        var lastIndex = endIndex
        for (_, element) in pathGrid.reverse().enumerate() {
            lastIndex = normalizeIndex(element[lastIndex], range:element.count)
            path.append(lastIndex)
        }
        return path.reverse()
    }
    
    func analyzePath( path:[Int], grid:[[Int]] ) -> String {
        var totalCost = 0
        for (column, row) in path.enumerate() {
            if (totalCost + grid[column][row] > 50) {
                return "No\n\(totalCost)\n\(normalizePath(path, length: column))"
            }
            totalCost += grid[column][row]
        }
        return "Yes\n\(totalCost)\n\(normalizePath(path, length: path.count))"
    }

    func normalizePath( path:[Int], length:Int ) -> String {
        var output:[Int] = []
        for i in path[0..<length] {
            output.append(i+1)
        }
        return output.map(String.init).joinWithSeparator(" ")
    }
}