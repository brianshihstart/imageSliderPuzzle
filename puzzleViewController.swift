//
//  puzzleViewController.swift
//  imageSlider
//
//  Created by Brian Shih on 8/30/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import UIKit

class puzzleViewController: UIViewController {
    var imageToPassOn: UIImage!
    
    @IBOutlet weak var board: Board!
    
    override func viewDidLoad() {
        board.chosenImage = self.imageToPassOn
        self.board.setUpBasics()
        
        
    }
}
