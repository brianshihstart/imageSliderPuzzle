//
//  matrixPosition.swift
//  imageSlider
//
//  Created by Brian Shih on 8/31/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//


import Foundation


class MatrixPosition {
    let rowIndex: Int!
    let columnIndex: Int!
    
    
    init(index1 : Int, index2 : Int) {
        self.rowIndex = index1
        self.columnIndex = index2
    }
    
    
    func createUniqueInt() -> Int {
        print("test")
        return ((self.rowIndex * 10) + self.columnIndex)
    }
    
    
    func createUniqueTag() -> String {
        var uniqueTag = ""
        if self.rowIndex == 0 {
            uniqueTag += " "
        } else {
            uniqueTag += "\(self.rowIndex)"
        }
        
        uniqueTag += "\(self.columnIndex)"
        
        return uniqueTag
    }
    
}