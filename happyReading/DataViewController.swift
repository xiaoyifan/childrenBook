//
//  DataViewController.swift
//  happyReading
//
//  Created by Yifan Xiao on 4/12/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

import UIKit
import AVFoundation

class DataViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var imageUp: UIImageView!
    @IBOutlet weak var imageDown: UIImageView!
    
    var dataObject: AnyObject?
    var synthesizer: AVSpeechSynthesizer?
    var utterance:AVSpeechUtterance?

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
        
        let string = self.textLabel.text
        self.utterance = AVSpeechUtterance(string: string)
        utterance!.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance!.pitchMultiplier = 1.50
        utterance!.volume = 1.0
        utterance!.rate = AVSpeechUtteranceMinimumSpeechRate;
        utterance!.preUtteranceDelay = 0.2;
        utterance!.postUtteranceDelay = 0.2;
        
        self.synthesizer = AVSpeechSynthesizer()
        
        self.synthesizer!.delegate = self
        self.synthesizer!.pauseSpeakingAtBoundary(.Word)

        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.valueForKey("autoSpeak") === 1){
            self.synthesizer!.speakUtterance(utterance)        }
                }
    
    @IBAction func pressHomeButton(sender: AnyObject) {
        
       self.navigationController!.popToRootViewControllerAnimated(true)
    
    }
    
    @IBAction func speakToMe(sender: AnyObject) {
        self.synthesizer!.speakUtterance(utterance)

    }
    
    // MARK: AVSpeechSynthesizerDelegate
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: characterRange)
        textLabel.attributedText = mutableAttributedString
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        textLabel.attributedText = NSAttributedString(string: utterance.speechString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.synthesizer!.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }


}

