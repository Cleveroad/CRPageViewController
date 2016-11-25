//
//  CRPageViewController.m
//  Pods
//
//  Created by Sergey Chuchukalo on 5/25/16.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRPageViewController.h"

@interface CRPageViewController () <UIGestureRecognizerDelegate>

- (void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
- (void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
@property (strong, nonatomic) NSMutableArray <UIViewController*> * internalViewControllers;
@property (assign, nonatomic) CGFloat spaceHorizontal;
@property (assign, nonatomic) CGFloat spaceVertical;

@end

@implementation CRPageViewController

#pragma mark - Life circle VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRightOrange = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRightOrange.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightOrange];
    UISwipeGestureRecognizer *swipeLeftOrange = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    swipeLeftOrange.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftOrange];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.spaceHorizontal = (self.view.frame.size.width - self.childVCSize.width) / 2;
    self.spaceVertical = (self.view.frame.size.height - self.childVCSize.height) / 2;
    self.internalViewControllers = [NSMutableArray new];
    for (UIViewController* vc in self.viewControllers) {
        [self pushRightViewController:vc];
    }
    [self changeViewControllersWithNumber:self.countPageInController/2];
    [self performSelector:@selector(focusedCentralView) withObject:nil afterDelay:0.2];
}

- (void)focusedCentralView {
    if ([self.dataSource respondsToSelector:@selector(focusedViewController:)]) {
        [self.dataSource focusedViewController:self.internalViewControllers[self.countPageInController/2]];
    }
}

- (void)setSizeBetweenVC:(CGFloat)sizeBetweenVC {
    _sizeBetweenVC = sizeBetweenVC;
    [self changeViewControllersWithNumber:self.countPageInController/2];
}

- (void)setChildVCSize:(CGSize)childVCSize {
    _childVCSize = childVCSize;
    self.spaceHorizontal = (self.view.frame.size.width - self.childVCSize.width) / 2;
    self.spaceVertical = (self.view.frame.size.height - self.childVCSize.height) / 2;
    [self changeViewControllersWithNumber:self.countPageInController/2];
    
}

- (void)setOffsetOfHeightCentralVC:(CGFloat)OffsetOfHeightCentralVC {
    _OffsetOfHeightCentralVC = OffsetOfHeightCentralVC;
    [self changeViewControllersWithNumber:self.countPageInController/2];
}

#pragma mark - Push VC

- (void)pushRightViewController:(__kindof UIViewController *)viewController {
    viewController.view.frame = CGRectMake(self.view.frame.size.width,
                                           self.spaceVertical,
                                           self.childVCSize.width,
                                           self.childVCSize.height);
    [self createViewController:viewController];
    [self.internalViewControllers addObject:viewController];
    [self changeViewControllersWithNumber:self.countPageInController/2];
}

- (void)pushLeftViewController:(__kindof UIViewController *)viewController {
    viewController.view.frame = CGRectMake(0,
                                           self.spaceVertical,
                                           self.childVCSize.width,
                                           self.childVCSize.height);
    [self createViewController:viewController];
    [self.internalViewControllers insertObject:viewController atIndex:0];
    [self changeViewControllersWithNumber:self.countPageInController/2 + 1];
}

# pragma mark - gestureRecognizers

- (void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    if ([self.dataSource respondsToSelector:@selector(pageViewController:viewControllerBeforeViewController:)]) {
        UIViewController *newViewController = [self.dataSource pageViewController:self viewControllerBeforeViewController:self.internalViewControllers.firstObject];
        if (newViewController) {
            [self unfocused:self.countPageInController/2];
            [self pushLeftViewController:newViewController];
            [UIView animateKeyframesWithDuration:self.animationSpeed delay:0 options:self.animation animations:^{
                [self changeViewControllersWithNumber:self.countPageInController/2];
                if ([self.dataSource respondsToSelector:@selector(focusedViewController:)]) {
                    [self.dataSource focusedViewController:self.internalViewControllers[self.countPageInController/2]];
                }
            } completion:^(BOOL finished) {
            }];
            [self performSelector:@selector(popRightViewCintroller) withObject:nil afterDelay:self.animationSpeed];
        }
    }
}

- (void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    if ([self.dataSource respondsToSelector:@selector(pageViewController:viewControllerAfterViewController:)]) {
        UIViewController *newViewController = [self.dataSource pageViewController:self viewControllerAfterViewController:self.internalViewControllers.lastObject];
        if (newViewController) {
            [self unfocused:self.countPageInController/2];
            [self pushRightViewController:newViewController];
            [UIView animateKeyframesWithDuration:self.animationSpeed delay:0 options:self.animation animations:^{
                [self changeViewControllersWithNumber:self.countPageInController/2 + 1];
                if ([self.dataSource respondsToSelector:@selector(focusedViewController:)]) {
                    [self.dataSource focusedViewController:self.internalViewControllers[self.countPageInController/2 + 1]];
                }
            } completion:^(BOOL finished) {
            }];
            [self performSelector:@selector(popLeftViewCintroller) withObject:nil afterDelay:self.animationSpeed];
        }
    }
}

#pragma mark - Helpers

- (void)popRightViewCintroller {
    if (self.internalViewControllers.count >= 0) {
        [self removeViewController:self.internalViewControllers.lastObject];
        [self.internalViewControllers removeLastObject];
        [self changeViewControllersWithNumber:self.countPageInController/2];
    }
}

- (void)popLeftViewCintroller {
    if (self.internalViewControllers.count >= 0) {
        [self removeViewController:self.internalViewControllers.firstObject];
        [self.internalViewControllers removeObjectAtIndex:0];
        [self changeViewControllersWithNumber:self.countPageInController/2];
    }
}

- (void)createViewController:(__kindof UIViewController *)viewController {
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)removeViewController:(__kindof UIViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)unfocused:(NSInteger)numberOfFocusetView {
    if (self.internalViewControllers.count == self.countPageInController) {
        if ([self.dataSource respondsToSelector:@selector(unfocusedViewController:)]) {
            [self.dataSource unfocusedViewController:self.internalViewControllers[numberOfFocusetView]];
        }
    }
}

- (void)changeViewControllersWithNumber:(NSInteger) numberOfFocusetView {
    for (int i = 0; i < self.internalViewControllers.count; i++) {
        CGFloat originXForView = self.spaceHorizontal + (self.childVCSize.width + self.sizeBetweenVC) * (i - numberOfFocusetView);
        if (i == numberOfFocusetView) {
            self.internalViewControllers[i].view.frame = CGRectMake(originXForView, self.spaceVertical + self.OffsetOfHeightCentralVC,  self.childVCSize.width, self.childVCSize.height );
        } else {
            self.internalViewControllers[i].view.frame = CGRectMake(originXForView, self.spaceVertical, self.childVCSize.width, self.childVCSize.height);
        }
    }
}

@end
