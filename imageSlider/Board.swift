//
//  Board.swift
//  imageSlider
//
//  Created by Brian Shih on 8/30/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import UIKit

class Board: UIView {
    
    var chosenImage = UIImage()
    var tilesPerRow = 2
    var tileArray = [[Tile]]()
    
    

    
    // MARK: prepare
    
    func initialise() {
        self.createBoard()
        self.layoutTiles()
        self.shuffleTiles()
    }
    
    func createBoard() {
        var widthOfChosenImage: CGFloat = CGFloat(CGImageGetWidth(self.chosenImage.CGImage))
        var widthPerTileImage = widthOfChosenImage / CGFloat(tilesPerRow)
        
        for yIndex in 0..<tilesPerRow {
        
            var rowArray = [Tile]()
            
            for xIndex in 0..<tilesPerRow {
                var positionIn2D = MatrixPosition(index1: yIndex, index2: xIndex)
                var newTile = Tile(matrixPos: positionIn2D)
                newTile.imageView.userInteractionEnabled = true
                newTile.imageView.tag = positionIn2D.createUniqueInt()
                
                // tile's frame:
                var positionYInImage = CGFloat(yIndex) * widthPerTileImage
                var positionXInImage = CGFloat(xIndex) * widthPerTileImage
                var imageFrame = CGRect(x: positionXInImage, y: positionYInImage, width: widthPerTileImage, height: widthPerTileImage)
                var tileImageCroppedFromChosenImage = CGImageCreateWithImageInRect(self.chosenImage.CGImage, imageFrame)
                newTile.imageSection = UIImage(CGImage: tileImageCroppedFromChosenImage!)
                newTile.imageView.image = newTile.imageSection
                
                
                var frame: CGRect
                
                
                
            }
            
            
        }
        
    }
    
    func layoutTiles() {
        
    }
    
    func shuffleTiles() {
        
    }
    
    // initialise
    // create tile array
    // layout tiles
    
    
    
    // shuffle tiles
    // swap tiles
    
}





