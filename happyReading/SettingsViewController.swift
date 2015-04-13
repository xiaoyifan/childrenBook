//
//  SettingsViewController.swift
//  happyReading
//
//  Created by admin on 4/13/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var parentalView: UIView!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var answerField: UITextField!
    
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var snap: UISnapBehavior!
    
    var square: Box!            // A box we will throw around
    var boxes: [Box] = [Box]()  // Keep a collection of our boxes
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if sender.on{
         println("Switch is ON");
            defaults.setInteger(1, forKey: "autoSpeak")
            defaults.synchronize()
            
        }
        else{
         println("Switch is OFF");
            defaults.setInteger(0, forKey: "autoSpeak")
            defaults.synchronize()
        }
    }
    
    
    @IBAction func backHome(sender: UIButton) {
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func cancelButton(sender: UIButton) {
        
         self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func submit(sender: UIButton) {
        
        if self.answerField.text == "15"{
        self.parentalView.alpha = 0
        }
        else{
            var alert = UIAlertController(title: "The answer is wrong", message: "please answer the question again, or you can leave", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    func setup() {
        
        animator = UIDynamicAnimator(referenceView: parentalView)
        
        // Gravity
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVectorMake(0, 5)
        animator.addBehavior(gravity)
        
        // Collision
        collision = UICollisionBehavior()
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        // Items Behavior
        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.75
        itemBehavior.friction = 0.4
        self.itemBehavior.resistance = 0.5;
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        createBoxes()
    }
    
    //: MARK - Box Methods
    func createBoxes() {
        for idx in 1...30{
            let box = Box(number: idx)
            box.layer.cornerRadius = 25;
            parentalView.addSubview(box)
            makeBoxDynamic(box)
            boxes.append(box)
        }
    }
    
    func makeBoxDynamic(box: UIView) {
        gravity.addItem(box)
        collision.addItem(box)
        itemBehavior.addItem(box)
    }
    
    //: MARK - UICollisionBehavior Delegate Methods
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        println("Item: \(item) hit point: \(p)")
        
        let collidingView = item as! Box
        collidingView.backgroundColor = UIColor.yellowColor()
        UIView.animateWithDuration(0.3) {
            collidingView.backgroundColor = collidingView.color
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        let touch = touches.first as! UITouch
        snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
        animator.addBehavior(snap)
    }

    

}
