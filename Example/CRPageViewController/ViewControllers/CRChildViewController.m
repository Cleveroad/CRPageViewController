//
//  CRChildViewController.m
//  CRPageViewController
//
//  Created by Sergey on 5/26/16.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRChildViewController.h"

@interface CRChildViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;

@end

@implementation CRChildViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.nameLabel.text = self.sourse[0];
    self.yearsLabel.text = [NSString stringWithFormat:@"%@ Years", self.sourse[1]];
    self.faceImageView.image = [UIImage imageNamed:self.nameLabel.text];
    self.faceImageView.layer.cornerRadius = 50;
    self.faceImageView.layer.borderWidth = 2;
    self.faceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.faceImageView.layer setMasksToBounds:YES];
}

- (void)zoomingImageIn {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rectOfImage = self.carImageView.frame;
        rectOfImage.origin.x -= 15;
        rectOfImage.origin.y -= 15;
        rectOfImage.size.height += 30;
        rectOfImage.size.width += 30;
        self.carImageView.frame = rectOfImage;
    } completion:^(BOOL finished) {
    }];
}

- (void)zoomingImageOut {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rectOfImage = self.carImageView.frame;
        rectOfImage.origin.x += 15;
        rectOfImage.origin.y += 15;
        rectOfImage.size.height -= 30;
        rectOfImage.size.width -= 30;
        self.carImageView.frame = rectOfImage;
    } completion:^(BOOL finished) {
    }];
}

@end
