//
//  SettingsViewController.swift
//  happyReading
//
//  Created by admin on 4/13/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var dynamicsView: UIView!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
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
    
    
    func setup() {
        
        let barrier = UIView(frame: CGRect(x: 0, y: 150, width: 50, height: 20))
        barrier.backgroundColor = UIColor.blackColor()
        dynamicsView.addSubview(barrier)
        
        animator = UIDynamicAnimator(referenceView: dynamicsView)
        
        // Gravity
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVectorMake(0, 9.8)
        animator.addBehavior(gravity)
        
        // Collision
        collision = UICollisionBehavior()
        collision.collisionDelegate = self
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        // Items Behavior
        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.9
        itemBehavior.friction = 0.1
        
        square = Box(number: 100)
        dynamicsView.addSubview(square)
        collision.addItem(square)
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
        for idx in 1...10 {
            let box = Box(number: idx)
            dynamicsView.addSubview(box)
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
        if collidingView.tag == 9 {
            gravity.gravityDirection = CGVectorMake(0, 0.0)
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
