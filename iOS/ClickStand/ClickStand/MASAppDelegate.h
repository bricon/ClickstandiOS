//
//  MASAppDelegate.h
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MASAppDelegate : UIResponder <UIApplicationDelegate, RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RESideMenu *sideMenuViewController;

@end
