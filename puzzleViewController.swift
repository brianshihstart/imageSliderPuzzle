//
//  puzzleViewController.swift
//  imageSlider
//
//  Created by Brian Shih on 8/30/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import UIKit

class puzzleViewController: UIViewController {
    
    @IBOutlet weak var board: Board!
    
    override func viewDidLoad() {
        self.board.setUpBasics()
        
        
    }
}
