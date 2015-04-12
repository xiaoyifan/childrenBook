//
//  ModelController.h
//  happyReading
//
//  Created by Yifan Xiao on 4/12/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

