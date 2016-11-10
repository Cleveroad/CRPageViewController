//
//  CRPageViewController.h
//  Pods
//
//  Created by Sergey Chuchukalo on 5/25/16.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import <UIKit/UIKit.h>
@class CRPageViewController;

@protocol CRPageViewControllerDataSource <NSObject>
@required
/**
 * Returns the view controller after the given view controller.
 *
 * @param pageViewController The page view controller
 * @param viewController  The view controller that the user navigated away from.
 * @return The view controller after the given view controller, or nil to indicate that there is no next view controller.
 */
- (UIViewController *)pageViewController:(CRPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController;

/**
 * Returns the view controller before the given view controller.
 * @param pageViewController The page view controller
 * @param viewController The view controller that the user navigated away from.
 * @return The view controller before the given view controller, or nil to indicate that there is no previous view controller.
 */
- (UIViewController *)pageViewController:(CRPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController;

@optional
/**
 * ViewController moving to center PageController
 *
 * @param viewController is ViewController what moving to center PageController
 */
- (void)focusedViewController:(UIViewController *)viewController;

/**
 * ViewController moving from center PageController
 *
 * @param viewController is ViewController what moving from center PageController
 */
- (void)unfocusedViewController:(UIViewController *)viewController;
@end

/**
 *   CRPageViewController is customise PageViewController. CRPageViewController allows implement cards form of UIViewController.
 */
@interface CRPageViewController : UIViewController

/**
 *  DataSourse of PageViewController
 */
@property (weak, nonatomic) id <CRPageViewControllerDataSource> dataSource;

/**
 *  Starting array of UIViewController in PageViewController
 */
@property (strong, nonatomic) NSArray <UIViewController*> *viewControllers;
/**
 *  Size of UIViewController in PageViewController
 */
@property (assign, nonatomic) CGSize childVCSize;

/**
 *  Vertical offset of UIViewController in center screen
 */
@property (assign, nonatomic) CGFloat OffsetOfHeightCentralVC;

/**
 *  Distance between child UIViewController
 */
@property (assign, nonatomic) CGFloat sizeBetweenVC;

/**
 *  Speed of animation change UIViewController on center PageViewController
 */
@property (assign, nonatomic) CGFloat animationSpeed;

/**
 *  Type of animation change UIViewController on center PageViewController
 */
@property (assign, nonatomic) UIViewAnimationCurve animation;

/**
 *  Count of UIViewController on PageViewController
 */
@property (assign, nonatomic) NSInteger countPageInController;

@end
