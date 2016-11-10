//
//  QSRateControl.h
//
//  Created by Sergey on 5/10/16.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface QSRateControl : UIControl

@property (nonatomic) IBInspectable UIImage *image;
@property (nonatomic) IBInspectable NSInteger spacing;
@property (nonatomic) IBInspectable NSInteger rating;
@property (nonatomic) IBInspectable UIColor *inactiveTintColor;
@property (nonatomic, copy) NSArray <UIColor *> *tintColors;

@end
