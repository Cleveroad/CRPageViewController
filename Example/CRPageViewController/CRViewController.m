//
//  CRViewController.m
//  CRPageViewController
//
//  Created by Sergey on 05/25/2016.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRViewController.h"
#import "CRPageViewController.h"
#import "CRChildViewController.h"

@interface CRViewController () <CRPageViewControllerDataSource>

@property (strong, nonatomic) CRPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray <CRChildViewController*> *sourse;
@property (assign, nonatomic) NSInteger viewControllersNumber;
@property (strong, nonatomic) NSArray *dataSourse;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *selectSizeValue;
@property (weak, nonatomic) IBOutlet UILabel *selectHeightOffset;
@property (weak, nonatomic) IBOutlet UILabel *selectHeightVC;
@property (weak, nonatomic) IBOutlet UILabel *selectWidthVC;
@property (strong, nonatomic) CRChildViewController *curentVC;
@property (assign, nonatomic) BOOL isChangeSize;

@end

@implementation CRViewController

#pragma mark - life circle

- (void)viewDidLoad {
    [self setEditing:NO animated:NO];
}

#pragma mark - user interaction

- (IBAction)sizeBetWeenVCChanged:(UISlider *)sender {
    self.pageViewController.sizeBetweenVC = sender.value;
    self.selectSizeValue.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

- (IBAction)centralVCHeightOffsetChanged:(UISlider *)sender {
    self.pageViewController.OffsetOfHeightCentralVC = sender.value;
    self.selectHeightOffset.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

- (IBAction)heightVCChanged:(UISlider *)sender {
    self.pageViewController.childVCSize = CGSizeMake(self.pageViewController.childVCSize.width, sender.value);
    self.selectHeightVC.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    self.isChangeSize = YES;
}

- (IBAction)widthVCChanged:(UISlider *)sender {
    self.pageViewController.childVCSize = CGSizeMake(sender.value, self.pageViewController.childVCSize.height);
    self.selectWidthVC.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    self.isChangeSize = YES;
}

- (IBAction)settingsButtonTap:(id)sender {
    [self setEditing:!self.isEditing animated:YES];
    if ((!self.isEditing) && (self.isChangeSize)){
        [self.curentVC zoomingImageIn];
        self.isChangeSize = NO;
    }
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.dataSourse = @[@[@"Tristan" ,@"52"],
                        @[@"Victor"  ,@"36"],
                        @[@"Ali"     ,@"48"],
                        @[@"Anton"   ,@"47"],
                        @[@"Peppi"   ,@"24"],
                        @[@"Kassy"   ,@"22"],
                        @[@"Kris"    ,@"30"],
                        @[@"Dany"    ,@"29"],
                        @[@"Lara"    ,@"45"],
                        @[@"Sara"    ,@"61"],
                        @[@"Alison"  ,@"18"],
                        @[@"Rebeca"  ,@"32"],
                        @[@"Andy"    ,@"29"],
                        @[@"Sandy"   ,@"45"],
                        @[@"Jorje"   ,@"64"],
                        @[@"Kavin"   ,@"31"],
                        @[@"Sadric"  ,@"72"],
                        @[@"Mike"    ,@"33"],
                        @[@"Sasha"   ,@"19"],
                        @[@"Larisa"  ,@"32"],
                        @[@"Jade"    ,@"48"]];
    if ([segue.destinationViewController isKindOfClass:[CRPageViewController class]]) {
        self.pageViewController = [CRPageViewController new];
        self.sourse = [NSMutableArray new];
        self.viewControllersNumber = 3;
        for (int i = 0; i < self.viewControllersNumber; i++) {
            [self.sourse addObject:[self createViewControllerWithNumber:i]];
        }
        self.pageViewController = (CRPageViewController *)segue.destinationViewController;
        self.pageViewController.countPageInController = self.viewControllersNumber;
        self.pageViewController.childVCSize = CGSizeMake(250, 500);
        self.pageViewController.sizeBetweenVC = 10;
        self.pageViewController.OffsetOfHeightCentralVC = 0;
        self.pageViewController.animationSpeed = 0.5;
        self.pageViewController.animation = UIViewAnimationCurveEaseInOut;
        self.pageViewController.viewControllers = [NSMutableArray arrayWithArray:self.sourse];
        self.pageViewController.dataSource = self;
        for (int i = (int)self.viewControllersNumber; i < 10; i++) {
            [self.sourse addObject:[self createViewControllerWithNumber:i]];
        }
    }
}

#pragma mark - helper

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    UIImage *buttonImage = editing ? [UIImage imageNamed:@"ic_done"] : [UIImage imageNamed:@"ic_settings"];
    NSTimeInterval duration = animated ? 0.5 : 0.0;
    [self.menuBarButtonItem setImage:buttonImage];
    CGAffineTransform transform = editing ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, - self.editView.frame.size.height - 100);
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.editView.transform = transform;
                     } completion:nil];
}

- (CRChildViewController*)createViewControllerWithNumber: (float) number {
    CRChildViewController *childVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"childVC"];
    NSArray *sourse = self.dataSourse[[NSNumber numberWithFloat:number].integerValue];
    childVC.sourse = sourse;
    return childVC;
}

#pragma mark - CRPageViewControllerDelegate

- (void)unfocusedViewController:(CRChildViewController *)viewController {
    [viewController zoomingImageOut];
}

- (void)focusedViewController:(CRChildViewController *)viewController {
    self.curentVC = viewController;
    [viewController zoomingImageIn];
}

- (CRChildViewController *)pageViewController:(CRPageViewController *)pageViewController viewControllerAfterViewController:(CRChildViewController *)viewController {
    NSInteger numberViewControllerInSourse = [self.sourse indexOfObject:viewController] + 1;
    if (numberViewControllerInSourse >= self.sourse.count) {
        numberViewControllerInSourse = 0;
    }
    return self.sourse[numberViewControllerInSourse];
}

- (CRChildViewController *)pageViewController:(CRPageViewController *)pageViewController viewControllerBeforeViewController:(CRChildViewController *)viewController {
    NSInteger numberViewControllerInSourse = [self.sourse indexOfObject:viewController] - 1;
    if (numberViewControllerInSourse < 0) {
        numberViewControllerInSourse = self.sourse.count - 1;
    }
    return self.sourse[numberViewControllerInSourse];
}

@end
