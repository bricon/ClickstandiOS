//
//  MASLogin.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASLoginViewController.h"
#import "MASFeedViewController.h"

@implementation MASLoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.facebookLoginButton setImage:[UIImage imageNamed:@"facebook-highlighted"]
                              forState:UIControlStateHighlighted];
}

- (IBAction)didTouchUpInsideButton:(UIButton *)sender
{
    if(sender == self.facebookLoginButton) {
        NSLog(@"Attempting to log in the PFUser using facebook");
        
        NSArray *permissionsArray = @[@"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
        
        [PFFacebookUtils initializeFacebook];
        [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
            if (!user) {
                if (!error) {
                    NSLog(@"User cancelled Facebook login.");
                } else {
                    NSLog(@"Uh oh. An error occurred: %@", error);
                }
            } else if (user.isNew) { // TODO: You can consolidate these into one if statement. Left for debugging. 
                NSLog(@"User with facebook signed up and logged in!");
                self.feedViewController = [[MASFeedViewController alloc] initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]];
                [self presentViewController:self.feedViewController animated:YES completion:nil];
            } else {
                NSLog(@"User with facebook logged in!");
                self.feedViewController = [[MASFeedViewController alloc] initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]];
                [self presentViewController:self.feedViewController animated:YES completion:nil];
            }
        }];

    } else if(sender == self.twitterLoginButton) {
        // TODO Login with Twitter
    }
}
@end
