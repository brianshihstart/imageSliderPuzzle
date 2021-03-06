//
//  DoubleIndex.swift
//  imageSlider
//
//  Created by Brian Shih on 8/30/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import Foundation


class DoubleIndex {
    let rowIndex: Int!
    let columnIndex: Int!
    
    
    init(index1 : Int, index2 : Int) {
        self.rowIndex = index1
        self.columnIndex = index2
    }
    
    
    func concatenateToInt() -> Int {
        print("test")
        return ((self.rowIndex * 10) + self.columnIndex)
    }
    
    
    func concatenateToString() -> String {
        var concatenationString = ""
        if self.rowIndex == 0 {
            concatenationString += " "
        } else {
            concatenationString += "\(self.rowIndex)"
        }
        
        concatenationString += "\(self.columnIndex)"
        
        return concatenationString
    }
    
}