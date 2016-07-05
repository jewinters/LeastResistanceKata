//
//  LeastResistanceCalculator.swift
//  LeastResistanceKata
//
//  Created by Jeremy Winters on 7/5/16.
//  Copyright © 2016 Jeremy Winters. All rights reserved.
//

import Foundation

class LeastResistanceCalculator {
    
    func validateInput(input:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".(\\d|\\s)", options: NSRegularExpressionOptions.CaseInsensitive)
            return regex.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count)).count > 0
        } catch {
            return false
        }
    }
}