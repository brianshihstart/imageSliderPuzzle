//
//  tile.swift
//  imageSlider
//
//  Created by Brian Shih on 8/31/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import UIKit

class Tile {
    
    var imageSection = UIImage()
    var imageView = UIImageView()
    var positionWithinArray : MatrixPosition!
    var orientationCount : CGFloat = 1
    var originalFrame: CGRect?
    
    init(matrixPos: MatrixPosition) {
        self.positionWithinArray = matrixPos
    }
    
    
    func getMatrixIndex() -> MatrixPosition {
        return self.positionWithinArray
    }
}