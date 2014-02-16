//
//  MASAppDelegate.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASAppDelegate.h"
#import "MASLoginViewController.h"
#import "MASFeedViewController.h"
#import "MASMenuViewController.h"

@implementation MASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor darkGrayColor];
    
    // Parse ID and Key. Change after handing over to Clickstand
    [Parse setApplicationId:@"hxjc7PsqUeQww2KZSMfMp3ZhFajFZHCT0JIPeR1t"
                  clientKey:@"hNNr6ZZNrADDD5Cgxt5ThKc9GdB6GqUZQnk4Z1hB"];
    
    // To be filled with facebook and twitter credentials
    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey:@"1sEf6eJhL0Ml8X249AYLKg" consumerSecret:@"jhvg6Ox8BfYYmbnTGXzMRB4VCy0zV3oTvVjaPo"];
    
    // Track statistics and analytics through Parse 
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Initialize root view controller
    MASMenuViewController *menuViewController = [[MASMenuViewController alloc]initWithNibName:@"MASMenuViewController"
                                                                                       bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[[MASFeedViewController alloc]initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]]];

    //venmo
    [self initVTClient];
    
    self.sideMenuViewController = [[RESideMenu alloc]initWithContentViewController:navigationController menuViewController:menuViewController];
    self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"menuBackground"];
    if ([PFUser currentUser]) {     // If the user is currently logged in skip the login page
        self.window.rootViewController = self.sideMenuViewController;
    } else {
        self.window.rootViewController = [[MASLoginViewController alloc]initWithNibName:@"MASLoginViewController"
                                                                                 bundle:[NSBundle mainBundle]];
    }

    [self configureAppearance];
    [self.window makeKeyAndVisible];
    return YES;
}

//venmo stuff
// Initialize a VTClient with your correct merchant settings.
- (void) initVTClient {
    if ([BT_ENVIRONMENT isEqualToString:@"sandbox"]) {
        [VTClient
         startWithMerchantID:BT_SANDBOX_MERCHANT_ID
         //TODO:change to real thing
         customerEmail:@"mebeweber@gmail.com"
         braintreeClientSideEncryptionKey:BT_SANDBOX_CLIENT_SIDE_ENCRYPTION_KEY
         environment:VTEnvironmentSandbox];
    } else {
        [VTClient
         startWithMerchantID:BT_PRODUCTION_MERCHANT_ID
         //TODO:change to real thing
         customerEmail:@"mebeweber@gmail.com"
         braintreeClientSideEncryptionKey:BT_PRODUCTION_CLIENT_SIDE_ENCRYPTION_KEY
         environment:VTEnvironmentProduction];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)configureAppearance
{
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor darkGrayColor]];
}

@end
