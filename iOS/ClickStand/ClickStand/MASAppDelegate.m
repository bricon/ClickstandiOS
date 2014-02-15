//
//  MASAppDelegate.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASAppDelegate.h"
#import <Parse/Parse.h>

@implementation MASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Parse ID and Key. Change after handing over to Clickstand
    [Parse setApplicationId:@"hxjc7PsqUeQww2KZSMfMp3ZhFajFZHCT0JIPeR1t"
                  clientKey:@"hNNr6ZZNrADDD5Cgxt5ThKc9GdB6GqUZQnk4Z1hB"];
    
    // Track statistics and analytics through Parse
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    return YES;
}

@end
