//
//  ViewController.swift
//  NASA_API
//
//  Created by Rebecca Bartels on 8/3/16.
//  Copyright © 2016 Rebecca Bartels. All rights reserved.
//

import UIKit
import Alamofire    // NSURL stuff baked in
import SwiftyJSON  //translator
import AlamofireImage

// never connect internet stuff to your viewdidload -- keep all that in its own task 
//all functions within this class are part of the superclass: UIViewController. 
//instance : a whole unique new thing 
//view controllers automatically have a view
class ViewController: UIViewController {
    
    
    
    //declaring this outside viewDidLoad enables us to access this property anywhere in our class.
    //RIGHT SIDE TO THE LEFT SIDE
    //inside a completion block you must say self bc it's too busy doing too many things.
    
    var imageView = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NasaAPI.getAPOD { (spaceImage) in
            self.imageView.image = spaceImage
            self.view.addSubview(self.imageView)
            self.imageView.translatesAutoresizingMaskIntoConstraints = false 
            self.imageView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
            self.imageView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
            self.imageView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
            self.imageView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
            
        }
        //we cannot set up our views outside completion block


       
      
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

