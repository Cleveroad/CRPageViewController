//
//  CRAppDelegate.m
//  CRPageViewController
//
//  Created by Sergey on 05/25/2016.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRAppDelegate.h"
#import "GSTouchesShowingWindow.h"

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (GSTouchesShowingWindow *)window {
    static GSTouchesShowingWindow *window = nil;
    if (!window) {
        window = [[GSTouchesShowingWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return window;
}

@end
