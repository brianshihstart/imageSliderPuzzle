//
//  introViewController.swift
//  imageSlider
//
//  Created by Brian Shih on 9/1/16.
//  Copyright © 2016 BrianShih. All rights reserved.
//

import UIKit

class introViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func button(sender: AnyObject) {
        performSegueWithIdentifier("toPuzzle", sender: self)

    }
    var imagePuzzle: UIImage?
    
    @IBAction func choosePhoto(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture, otherwise,
        // just pick from photo library
//        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
//            imagePicker.sourceType = .Camera
//        }
//        else {
            imagePicker.sourceType = .Camera
//        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        
        // Place image picker on the screen
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
//    func imagePickerController(picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String: AnyObject]) {
//        
//        // Get picked image from info dictionary
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        
//        imagePuzzle = image
//        dismissViewControllerAnimated(true, completion: nil)
////        performSegueWithIdentifier("toPuzzle", sender: self)
//    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("photo library")
        
        // Crop the picked image to square
        var imagePicked = info[UIImagePickerControllerEditedImage] as! UIImage
        var imageWidth  = imagePicked.size.width
        var imageHeight  = imagePicked.size.height
        var rect = CGRect()
        if (imageWidth < imageHeight) { // Image is in potrait mode
            rect = CGRectMake (0, (imageHeight - imageWidth) / 2, imageWidth, imageWidth);
        } else { // Image is in landscape mode
            rect = CGRectMake ((imageWidth - imageHeight) / 2, 0, imageHeight, imageHeight);
        }
        var croppedCGImage = CGImageCreateWithImageInRect(imagePicked.CGImage, rect)
        var croppedUIImage = UIImage(CGImage: croppedCGImage!)
        
        // Update currentImagePackage
               self.imagePuzzle = croppedUIImage
        // Dismiss picker
        picker.dismissViewControllerAnimated(true, completion: nil)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPuzzle" {
            if let destinationVC = segue.destinationViewController as? puzzleViewController {
                destinationVC.imageToPassOn = self.imagePuzzle!

        }
        }
    }
    
    
    

}
