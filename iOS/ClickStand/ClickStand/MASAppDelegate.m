//
//  MASAppDelegate.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASAppDelegate.h"
#import "MASLoginViewController.h"
#import "MASHomeViewController.h"
#import "MASFeedViewController.h"

@implementation MASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    // Parse ID and Key. Change after handing over to Clickstand
    [Parse setApplicationId:@"hxjc7PsqUeQww2KZSMfMp3ZhFajFZHCT0JIPeR1t"
                  clientKey:@"hNNr6ZZNrADDD5Cgxt5ThKc9GdB6GqUZQnk4Z1hB"];
    
    // To be filled with facebook and twitter credentials
    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey:@"1sEf6eJhL0Ml8X249AYLKg" consumerSecret:@"jhvg6Ox8BfYYmbnTGXzMRB4VCy0zV3oTvVjaPo"];
    
    // Track statistics and analytics through Parse 
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Initialize root view controller
    if ([PFUser currentUser]) {     // If the user is currently logged in skip the login page
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[[MASFeedViewController alloc]initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]]];
        self.window.rootViewController = navigationController;
    } else {
        self.window.rootViewController = [[MASLoginViewController alloc]initWithNibName:@"MASLoginViewController"
                                                                                 bundle:[NSBundle mainBundle]];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

@end
