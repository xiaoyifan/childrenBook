//
//  DataViewController.swift
//  happyReading
//
//  Created by Yifan Xiao on 4/12/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var imageUp: UIImageView!
    @IBOutlet weak var imageDown: UIImageView!
    
    var dataObject: AnyObject?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.homeButton.backgroundColor = UIColor.clearColor()
        
        let imageUpName: String! = dataObject!.objectForKey("images")!.objectAtIndex(0) as! String
        let imageDownName: String! = dataObject!.objectForKey("images")!.objectAtIndex(1) as! String
        
        imageUp.image = UIImage(named: imageUpName)
        imageDown.image = UIImage(named: imageDownName)
        
        
        var duration: NSTimeInterval = 15.0
        var rotateTransform: CGAffineTransform = CGAffineTransformRotate(self.imageUp.transform, CGFloat(M_PI))
        
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.Repeat, animations: {
        
            self.imageUp.transform = rotateTransform
            
            }, completion: nil)
        
        
        
        UIView.animateWithDuration(3.0, delay: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            var f:CGRect = self.imageDown.frame
            f.origin.x = -15;
            self.imageDown.frame = f
            
            
        
        }, completion: nil)
        
        
        let titleText: String = dataObject!.objectForKey("title") as! String
        
        self.titleLabel.text = titleText
        println(self.titleLabel.text)
        
        let textFromList:String = dataObject?.objectForKey("lyrics") as! String
        let myNewLineStr = "\n"
        let lyricsInLine = textFromList.stringByReplacingOccurrencesOfString("\\n", withString: myNewLineStr)
        
        self.textLabel.text = lyricsInLine
        self.textLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.textLabel.numberOfLines = 0
        
        
    }
    
    @IBAction func pressHomeButton(sender: AnyObject) {
        
       self.navigationController!.popToRootViewControllerAnimated(true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }


}

