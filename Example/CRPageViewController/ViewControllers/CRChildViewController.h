//
//  CRChildViewController.h
//  CRPageViewController
//
//  Created by Sergey on 5/26/16.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import <UIKit/UIKit.h>

@interface CRChildViewController : UIViewController

@property (strong, nonatomic) NSArray *sourse;

- (void)zoomingImageIn;
- (void)zoomingImageOut;

@end
