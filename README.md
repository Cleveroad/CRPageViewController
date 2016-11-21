# CRPageViewController [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome) <img src="https://www.cleveroad.com/public/comercial/label-ios.svg" height="20"> <a href="https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts"><img src="https://www.cleveroad.com/public/comercial/label-cleveroad.svg" height="20"></a>

[![CI Status](http://img.shields.io/travis/Sergey/CRPageViewController.svg?style=flat)](https://travis-ci.org/Sergey/CRPageViewController)
[![Version](https://img.shields.io/cocoapods/v/CRPageViewController.svg?style=flat)](http://cocoapods.org/pods/CRPageViewController)
[![License](https://img.shields.io/cocoapods/l/CRPageViewController.svg?style=flat)](http://cocoapods.org/pods/CRPageViewController)
[![Platform](https://img.shields.io/cocoapods/p/CRPageViewController.svg?style=flat)](http://cocoapods.org/pods/CRPageViewController)

![Header image](/images/header.jpg)

## Meet CRPageViewController - Customizable PageViewController for iOS

Cleveroad is happy to present a new library for iOS apps — CRPageViewController. CRPageViewController is customise PageViewController. CRPageViewController allows implement cards form of UIViewController.

![Demo image](/images/demo.gif)

If you want to take cards form of UIViewController, take CRPageViewController. Integrate your iOS app with CRPageViewController library and try out all the benefits it provides.

[![Awesome](/images/logo-footer.png)](https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts)
<br/>

## Requirements

* iOS 8 or higher

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CRPageViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "CRPageViewController"
```
and run pod install in terminal.
Usage


## CRPageViewController

```c
@protocol CRPageViewControllerDataSource <NSObject>
@required

//Returns the view controller after the given view controller.
- (UIViewController *)pageViewController:(CRPageViewController *)pageViewController
viewControllerAfterViewController:(UIViewController *)viewController;

//Returns the view controller before the given view controller.
- (UIViewController *)pageViewController:(CRPageViewController *)pageViewController
viewControllerBeforeViewController:(UIViewController *)viewController;

@optional

//ViewController moving to center PageController
- (void)focusedViewController:(UIViewController *)viewController;

//ViewController moving from center PageController
- (void)unfocusedViewController:(UIViewController *)viewController;

CRPageViewController

//DataSourse of PageViewController
@property (weak, nonatomic) id <CRPageViewControllerDataSource> dataSource;

//Starting array of UIViewController in PageViewController
@property (strong, nonatomic) NSArray <UIViewController*> *viewControllers;

//Size of UIViewController in PageViewController
@property (assign, nonatomic) CGSize childVCSize;

//Vertical offset of UIViewController in center screen
@property (assign, nonatomic) CGFloat OffsetOfHeightCentralVC;

//Distance between child UIViewController
@property (assign, nonatomic) CGFloat sizeBetweenVC;

//Speed of animation change UIViewController on center PageViewController
@property (assign, nonatomic) CGFloat animationSpeed;

//Type of animation change UIViewController on center PageViewController
@property (assign, nonatomic) UIViewAnimationCurve animation;

//Count of UIViewController on PageViewController
@property (assign, nonatomic) NSInteger countPageInController;

```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Support

If you have any other questions regarding the use of this library, please contact us for support at info@cleveroad.com (email subject: "CRPageViewController. Support request.") 

## Author

[Sergey Chuchukalo](Chuchukalo.cr@gmail.com)

## License

The MIT License (MIT)

Copyright (c) 2016 Cleveroad Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
