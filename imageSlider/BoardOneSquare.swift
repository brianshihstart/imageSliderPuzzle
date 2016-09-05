//
//  BoardOneSquare.swift
//  imageSlider
//
//  Created by Brian Shih on 9/3/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import UIKit



class BoardOneSquare: UIView {
    
    var chosenImage:UIImage!
    var tilesPerRow = 3
    var tileArray = [[Tile]]()
    
    var firstTileSelected: Tile!
    var secondTileSelected: Tile!
    var tileYouAreLookingFor: Tile!
    
    
    func addPanGesture() {
        let tapTileGesture = UITapGestureRecognizer(target: self, action: "tappedTile:")
        self.addGestureRecognizer(tapTileGesture)
        
        let dragTileGesture = UIPanGestureRecognizer(target: self, action: "draggedTile:")
        self.addGestureRecognizer(dragTileGesture)
        
        
    }
    
    // MARK: prepare
    
    func setUpBasics() {
        
        
        self.addPanGesture()
        
        //        self.chosenImage = UIImage(named: "birdPicture.png")!
        
        self.createBoard()
        self.layoutTiles()
        print(tileArray[1].count)
        
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
                
                var totalWidth = self.frame.width
                var tileFrame = CGRectMake(totalWidth / 2, totalWidth / 2, 0, 0)
                newTile.imageView.frame = tileFrame
                
                // tile's frame:
                var positionYInImage = CGFloat(yIndex) * widthPerTileImage
                var positionXInImage = CGFloat(xIndex) * widthPerTileImage
                var imageFrame = CGRect(x: positionXInImage, y: positionYInImage, width: widthPerTileImage, height: widthPerTileImage)
                var tileImageCroppedFromChosenImage = CGImageCreateWithImageInRect(self.chosenImage.CGImage, imageFrame)
                newTile.imageSection = UIImage(CGImage: tileImageCroppedFromChosenImage!)
                newTile.imageView.image = newTile.imageSection
                self.addSubview(newTile.imageView)
                
                rowArray.append(newTile)
            }
            
            self.tileArray.append(rowArray)
        }
        
    }
    
    func layoutTiles() {
        let tileWidth = self.frame.width / CGFloat(tilesPerRow)
        let tileHeight = self.frame.height / CGFloat(tilesPerRow)
        
        for i in 0 ..< tilesPerRow {
            let YwithinTileArea = CGFloat(i) * tileWidth
            
            for k in 0 ..< tilesPerRow {
                let XwithinTileArea = CGFloat(k) * tileWidth
                
                let puzzleFrame = CGRect(x: XwithinTileArea, y: YwithinTileArea, width: tileWidth, height: tileHeight)
                
                
                UIView.animateWithDuration(10, animations: <#T##() -> Void#>)
                UIView.animateWithDuration(10.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
                    
                    self.tileArray[i][k].imageView.frame = puzzleFrame
                    print(self.tileArray[i][k].imageView.frame)
                    
                }), completion: nil)
                
            }
            
            
            
        }
        
        
    }
    
    var count = 0
       func tileWithPointExists(point: CGPoint, isLookingFirst: Bool) -> Bool {
        for index1 in 0..<self.tilesPerRow {
            for index2 in 0..<self.tilesPerRow {
                self.tileYouAreLookingFor = self.tileArray[index1][index2]
                if CGRectContainsPoint(self.tileYouAreLookingFor!.imageView.frame, point) {
                    if isLookingFirst {
                        return true
                    } else { // searching for second tile
                        if self.tileYouAreLookingFor?.imageView.tag != self.firstTileSelected?.imageView.tag {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func swapMatrixPosition(tile1: Tile, tile2: Tile) {
        var tempTile1Matrix = tile1.getMatrixIndex()
        tile1.positionWithinArray = tile2.positionWithinArray
        tile2.positionWithinArray = tempTile1Matrix
    }
    
    func swapTiles(tile1: Tile, tile2: Tile, duration: NSTimeInterval, completionClosure: () ->()) {
        if tile1.imageView.tag == tile2.imageView.tag {
            return
        }
        
        swapMatrixPosition(tile1, tile2: tile2)
        
        self.insertSubview(tile2.imageView, belowSubview: tile1.imageView)
        
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            // Swap frames
            tile1.imageView.frame = tile2.originalFrame!
            tile2.imageView.frame = tile1.originalFrame!
            tile1.originalFrame = tile1.imageView.frame
            tile2.originalFrame = tile2.imageView.frame
            
            
            }, completion: { (finished) -> Void in
                completionClosure()
        })
        
        
    }
    
    
    // the position in the 2d array never changed. The thing that has changed is the frame and matrixPosition
    func checkCorrectPositionForAll() -> Bool {
        
        for i in 0..<tilesPerRow {
            for k in 0..<tilesPerRow {
                let tileToCheck = tileArray[i][k]
                if tileToCheck.getMatrixIndex().columnIndex != k || tileToCheck.getMatrixIndex().rowIndex != i {
                    return false
                }
            }
            
        }
        return true
    }
    
    func checkIfSolved() -> Bool {
        for index1 in 0..<self.tilesPerRow {
            for index2 in 0..<self.tilesPerRow {
                let tileToCheck = self.tileArray[index1][index2]
                if (tileToCheck.getMatrixIndex().rowIndex != index1
                    || tileToCheck.getMatrixIndex().columnIndex != index2)
                {
                    return false
                }
            }
        }
        print("gameOver")
        return true
    }
    
    
    func shuffleTiles() {
        
        for _ in 0..<19 {
            // Use arc4random_uniform(n) for a random integer between 0 and n-1
            let firstTileIndex1 = Int(arc4random_uniform(UInt32(tilesPerRow)))
            let firstTileIndex2 = Int(arc4random_uniform(UInt32(tilesPerRow)))
            let secondTileIndex1 = Int(arc4random_uniform(UInt32(tilesPerRow)))
            let secondTileIndex2 = Int(arc4random_uniform(UInt32(tilesPerRow)))
            
            var tile1 = tileArray[firstTileIndex1][firstTileIndex2]
            var tile2 = tileArray[secondTileIndex1][secondTileIndex2]
            
            tile1.originalFrame = tile1.imageView.frame
            tile2.originalFrame = tile2.imageView.frame
            
            swapTiles(tile1, tile2: tile2, duration: 0.3, completionClosure:{ () -> () in
            })
            
            
        }
        
    }
    
    // initialise
    // create tile array
    // layout tiles
    
    
    
    // shuffle tiles
    // swap tiles
    
    // MARK: Gesture Methods

    
//    let tapTileGesture = UITapGestureRecognizer(target: self, action: "tappedTile:")
//    self.addGestureRecognizer(tapTileGesture)
//    
//    let dragTileGesture = UIPanGestureRecognizer(target: self, action: "draggedTile:")
//    self.addGestureRecognizer(dragTileGesture)
    
    func tappedTile(gesture: UITapGestureRecognizer) {
        
    }
    
    func draggedTile(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Began:
            
        case .Changed:
            
        case.Ended:
            
        }
    }
    
    func moveTile(gesture:UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Began:
            let point :CGPoint = gesture.locationInView(self)
            if(tileWithPointExists(point, isLookingFirst: true)) {
                self.firstTileSelected = self.tileYouAreLookingFor!
                self.bringSubviewToFront(self.firstTileSelected!.imageView)
                self.firstTileSelected!.originalFrame = self.firstTileSelected!.imageView.frame
            }
            
            
        case .Changed:
            if((self.firstTileSelected) != nil) {
                let translation = gesture.translationInView(self)
                firstTileSelected.imageView.frame.origin.x += translation.x
                firstTileSelected.imageView.frame.origin.y += translation.y
                gesture.setTranslation(CGPointZero, inView: self)
                
            }
            
        case .Ended:
            if self.firstTileSelected != nil {
                let endingPoint :CGPoint = gesture.locationInView(self)
                
                if tileWithPointExists(endingPoint, isLookingFirst: false) {
                    self.secondTileSelected = self.tileYouAreLookingFor!
                    self.secondTileSelected!.originalFrame = self.secondTileSelected!.imageView.frame
                    self.swapTiles(self.firstTileSelected!, tile2: self.secondTileSelected!, duration: 0.3, completionClosure: { () -> () in
                        
                        self.checkIfSolved()
                        
                        
                    })
                }
                else {
                    print("hello")
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.firstTileSelected!.imageView.frame = self.firstTileSelected!.originalFrame!
                    })
                }
            }
            
            
        default:
            break
        }
        
        print("moved\(count)")
        count++
    }

    
}

func delay(delay:Double, closure:()->()){
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ), dispatch_get_main_queue(), closure)
}








