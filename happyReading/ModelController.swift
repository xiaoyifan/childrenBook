//
//  ModelController.swift
//  happyReading
//
//  Created by Yifan Xiao on 4/12/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

import UIKit


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData = NSArray()


    override init() {
        super.init()
        // Create the data model.
        let plistPath:String = NSBundle.mainBundle().pathForResource("PList", ofType: "plist")!
        
        pageData = NSArray(contentsOfFile: plistPath)!
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "pageNumber")
        defaults.synchronize()

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }

    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return self.pageData.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

