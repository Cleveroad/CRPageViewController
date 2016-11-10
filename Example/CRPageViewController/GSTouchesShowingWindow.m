//
//  GSAppPreviewTouchesWindow.m
//  Routes
//
//  Created by Lukas Petr on 16/08/14.
//  Copyright (c) 2014 Glimsoft. All rights reserved.
//

#import "GSTouchesShowingWindow.h"

#define TOUCH_IMAGE_NAME        @"GSTouchImage.png"

@interface GSTouchImageViewQueue : NSObject

- (id)initWithTouchesCount:(NSUInteger)count;

- (UIImageView *)popTouchImageView;
- (void)pushTouchImageView:(UIImageView *)touchImageView;

@end


@interface GSTouchesShowingWindow () {
    GSTouchImageViewQueue *_touchImgViewQueue;
    NSMutableDictionary *_touchImgViewsDict;
}

@property (nonatomic, readonly) GSTouchImageViewQueue *touchImgViewQueue;
@property (nonatomic, strong) NSMutableDictionary *touchImgViewsDict;

@end



@implementation GSTouchesShowingWindow


- (void)sendEvent:(UIEvent *)event {
    
	NSSet *touches = [event allTouches];
    
    for (UITouch *touch in touches) {
        
		switch ([touch phase]) {
                
			case UITouchPhaseBegan:
                [self touchBegan:touch];
				break;
                
			case UITouchPhaseMoved:
                [self touchMoved:touch];
				break;
                
            case UITouchPhaseEnded:
			case UITouchPhaseCancelled:
				[self touchEnded:touch];
				break;
                
			default:
				break;
		}
	}
    [super sendEvent:event];
}

- (void)touchBegan:(UITouch *)touch {
    UIImageView *touchImgView = [self.touchImgViewQueue popTouchImageView];
    touchImgView.center = [touch locationInView:self];
    [self addSubview:touchImgView];
    touchImgView.alpha = 0.0;
    touchImgView.transform = CGAffineTransformMakeScale(1.13, 1.13);
    [self setTouchImageView:touchImgView forTouch:touch];
    
    [UIView animateWithDuration:0.1 animations:^{
        touchImgView.alpha = 1.0f;
        touchImgView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)touchMoved:(UITouch *)touch {
    UIImageView *touchImgView = [self touchImageViewForTouch:touch];
    touchImgView.center = [touch locationInView:self];
}

- (void)touchEnded:(UITouch *)touch {
    UIImageView *touchImgView = [self touchImageViewForTouch:touch];
    [UIView animateWithDuration:0.1
                     animations:^{
                         touchImgView.alpha = 0.0f;
                         touchImgView.transform = CGAffineTransformMakeScale(1.13, 1.13);
                     } completion:^(BOOL finished) {
                         [touchImgView removeFromSuperview];
                         touchImgView.alpha = 1.0;
                         [self.touchImgViewQueue pushTouchImageView:touchImgView];
                         [self removeTouchImageViewForTouch:touch];
                     }];
}


- (UIImageView *)touchImageViewForTouch:(UITouch *)touch {
    NSString *touchStringHash = [NSString stringWithFormat:@"%lu", (unsigned long)[touch hash]];
    return self.touchImgViewsDict[touchStringHash];
}

- (void)setTouchImageView:(UIImageView *)imgView forTouch:(UITouch *)touch {
    NSString *touchStringHash = [NSString stringWithFormat:@"%lu", (unsigned long)[touch hash]];
    [self.touchImgViewsDict setObject:imgView forKey:touchStringHash];
}

- (void)removeTouchImageViewForTouch:(UITouch *)touch {
    NSString *touchStringHash = [NSString stringWithFormat:@"%lu", (unsigned long)[touch hash]];
    [self.touchImgViewsDict removeObjectForKey:touchStringHash];
}

- (GSTouchImageViewQueue *)touchImgViewQueue {
    if (_touchImgViewQueue == nil) {
        _touchImgViewQueue = [[GSTouchImageViewQueue alloc] initWithTouchesCount:8];
    }
    return _touchImgViewQueue;
}

- (NSMutableDictionary *)touchImgViewsDict {
    if (_touchImgViewsDict == nil) {
        _touchImgViewsDict = [[NSMutableDictionary alloc] init];
    }
    return _touchImgViewsDict;
}

@end



@interface GSTouchImageViewQueue ()

@property (nonatomic, strong) NSMutableArray *backingArray;

@end


@implementation GSTouchImageViewQueue

- (id)initWithTouchesCount:(NSUInteger)count {
    if (self = [super init]) {
        self.backingArray = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < count; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TOUCH_IMAGE_NAME]];
            [self.backingArray addObject:imgView];
        }
    }
    return self;
}

- (UIImageView *)popTouchImageView {
    UIImageView *touchImageView = [self.backingArray firstObject];
    [self.backingArray removeObjectAtIndex:0];
    return touchImageView;
}

- (void)pushTouchImageView:(UIImageView *)touchImageView {
    [self.backingArray addObject:touchImageView];
}

@end

