# CRPageViewController [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome) <img src="https://www.cleveroad.com/public/comercial/label-ios.svg" height="20"> <a href="https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts"><img src="https://www.cleveroad.com/public/comercial/label-cleveroad.svg" height="20"></a>

[![CI Status](http://img.shields.io/travis/Sergey/CRPageViewController.svg?style=flat)](https://travis-ci.org/Sergey/CRPageViewController)
[![Version](https://img.shields.io/cocoapods/v/CRPageViewController.svg?style=flat)](http://cocoapods.org/pods/CRPageViewController)
[![License](https://img.shields.io/cocoapods/l/CRPageViewController.svg?style=flat)](http://cocoapods.org/pods/CRPageViewController)
[![Platform](https://img.shields.io/cocoapods/p/CRPageViewController.svg?style=flat)](http://cocoapods.org/pods/CRPageViewController)

![Header image](/images/header.jpg)

## Meet Page View Controller for iOS by Cleveroad

Hey, guys! Cleveroad team has got something really interesting for you. Meet our new iOS library - CRPageViewController. We’re sure that you’ve already checked the convenience of Page View long time ago. But we’ve made something that will make navigation between pages of your app even handier.

![Demo image](/images/demo.gif)

While a standard page view allows you to navigate between pages by using simple gestures, our component goes further. CRPageViewController allows defining a page size by setting width and heights manually. Thus, users will be able to control the placement of pages on the screens in the way which is more suitable for them. 

We’re convinced that users will find this component really useful and will be grateful for such a good tool.  

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

If you have any questions, issues or propositions, please create a <a href="../../issues/new">new issue</a> in this repository.

If you want to hire us, send an email to sales@cleveroad.com or fill the form on <a href="https://www.cleveroad.com/contact">contact page</a>

Follow us:

[![Awesome](/images/social/facebook.png)](https://www.facebook.com/cleveroadinc/)   [![Awesome](/images/social/twitter.png)](https://twitter.com/cleveroadinc)   [![Awesome](/images/social/google.png)](https://plus.google.com/+CleveroadInc)   [![Awesome](/images/social/linkedin.png)](https://www.linkedin.com/company/cleveroad-inc-)   [![Awesome](/images/social/youtube.png)](https://www.youtube.com/channel/UCFNHnq1sEtLiy0YCRHG2Vaw)
<br/>

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
