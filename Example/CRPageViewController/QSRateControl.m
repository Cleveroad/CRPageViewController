//
//  QSRateControl.m
//
//  Created by Sergey on 5/10/16.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

static const long kCountOfImageInRateControl = 5;
#define defaultTintColorInactiveImageRateControl ([UIColor colorWithRed:0.757 green:0.757 blue:0.757 alpha:1.00])
#define defaultTintColorActiveImageRateControl ([UIColor colorWithRed:1 green:1 blue:1 alpha:1.00])

#import "QSRateControl.h"

@interface QSRateControl()

@property (nonatomic) NSMutableArray <UIImageView *> *imageViews;
@property (nonatomic) NSMutableArray <NSLayoutConstraint *> *spacingConstraints;

@end

@implementation QSRateControl

#pragma mark - Properties

- (void)setImage:(UIImage *)image {
    _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    for (UIImageView *imageView in self.imageViews) {
        imageView.image = _image;
    }
}

- (void)setSpacing:(NSInteger)spacing {
    _spacing = spacing;
    for (NSLayoutConstraint *spacingConstraint in self.spacingConstraints) {
        spacingConstraint.constant = spacing;
    }
    [self layoutIfNeeded];
}

- (void)setRating:(NSInteger)rating {
    _rating = rating;
    [self tintColorDidChange];
}

- (void)setInactiveTintColor:(UIColor *)inactiveTintColor {
    _inactiveTintColor = inactiveTintColor;
    [self tintColorDidChange];
}

- (void)setRating:(NSInteger)rating withEvent:(UIEvent *)event {
    self.rating = rating;
    if (event) {
        NSSet *allTouches = [event allTouches];
        UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
        CGPoint point = [touch locationInView:self];
        self.rating = point.x / ((self.frame.size.width + self.spacing) / kCountOfImageInRateControl);
        [self tintColorDidChange];
    }
}

- (void)setTintColors:(NSArray<UIColor *> *)tintColors {
    _tintColors = tintColors;
    [self tintColorDidChange];
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.imageViews = [NSMutableArray new];
    self.tintColor = defaultTintColorActiveImageRateControl;
    self.spacingConstraints = [NSMutableArray new];
    for (int i = 0; i < kCountOfImageInRateControl; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:self.image];
        imageView.tintColor = [UIColor whiteColor];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        [self.imageViews addObject:imageView];
        NSMutableArray *constraints = [NSMutableArray new];
        if (i == 0) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:imageView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:0]];
        } else {
            NSLayoutConstraint* spacingConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                                 attribute:NSLayoutAttributeLeading
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.imageViews[i - 1]
                                                                                 attribute:NSLayoutAttributeTrailing
                                                                                multiplier:1.0
                                                                                  constant:self.spacing];
            [constraints addObject:spacingConstraint];
            [self.spacingConstraints addObject:spacingConstraint];
            
            [constraints addObject:[NSLayoutConstraint constraintWithItem:imageView
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.imageViews[0]
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:0]];
        }
        if (i == kCountOfImageInRateControl - 1) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:imageView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0]];
        }
        [constraints addObject:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0]];
        [NSLayoutConstraint activateConstraints:constraints];
    }
}

#pragma mark -

- (void)tintColorDidChange {
    for (long i = 0; i < [self.imageViews count]; i ++) {
        if (self.rating < i) {
            if (self.inactiveTintColor) {
                self.imageViews[i].tintColor = self.inactiveTintColor;
            } else {
                self.imageViews[i].tintColor = defaultTintColorInactiveImageRateControl;
            }
        } else {
            if ([self.tintColors count] >= kCountOfImageInRateControl) {
                self.imageViews[i].tintColor = self.tintColors[i];
            } else {
                self.imageViews[i].tintColor = self.tintColor;
            }
        }
    }
}

- (CGSize)intrinsicContentSize {
    CGFloat height;
    CGFloat width;
    height = self.image.size.height;
    width = self.image.size.width;
    return CGSizeMake((((width + self.spacing) * kCountOfImageInRateControl) - self.spacing), height);
}

#pragma mark - Touches

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setRating:self.rating withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setRating:self.rating withEvent:event];
}

@end
