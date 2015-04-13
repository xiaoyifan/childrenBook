//
//  homePageViewController.swift
//  happyReading
//
//  Created by admin on 4/13/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

import UIKit

class homePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("RootViewController") as! UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func pressPlay(sender: AnyObject) {
      let rvc = self.storyboard!.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
        
       self.navigationController!.pushViewController(rvc, animated: true)
        
    }
    
    
    @IBAction func pressSettings(sender: AnyObject) {
        
        let rvc = self.storyboard!.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        
        self.navigationController!.pushViewController(rvc, animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
