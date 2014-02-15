//
//  UTCSSideMenuViewController.h
//  UTCS
//
//  Created by Comyar Zaheri on 2/12/14.
//  Copyright (c) 2014 UTCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASSideMenuViewController : UIViewController <UIGestureRecognizerDelegate>

- (instancetype)initWithContentController:(UIViewController *)contentController menuController:(UIViewController *)menuController;
- (void)presentMenuController;
- (void)hideMenuController;

@property (strong, nonatomic) UIImage                       *backgroundImage;
@property (strong, nonatomic, readonly) UIViewController    *contentController;
@property (strong, nonatomic, readonly) UIViewController    *menuController;

@end
