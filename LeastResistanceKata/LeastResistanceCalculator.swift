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
        if !validateInput(input) {
            return "Invalid input: please enter a grid of 1 to 10 rows and 5 to 100 columns of integers delimited by spaces.\nExample:\n1 2 3 4 5\n6 7 8 9 10\n-11 12 13 14 15"
        }
        return ""
    }
}