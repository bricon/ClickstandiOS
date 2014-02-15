//
//  MASLogin.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASLoginViewController.h"
#import "MASFeedViewController.h"
#import "MASSignUpViewController.h"

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
    [self.twitterLoginButton setImage:[UIImage imageNamed:@"twitter-highlighted"]
                             forState:UIControlStateHighlighted];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resetViewFrame];
    [self.view endEditing:YES];
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
            } else if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
                
                // Populate the new user's fields TODO: Make this populate the information
                FBRequest *request = [FBRequest requestForMe];
                [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        NSDictionary *userData = (NSDictionary *)result;
                        
                        NSString *facebookID = userData[@"id"];
                        NSString *name = userData[@"name"];
                        NSString *location = userData[@"location"][@"name"];
                        NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                        
                        [user setObject:name forKey:@"name"];
                        [user setObject:location forKey:@"location"];
                        [user setObject:pictureURL forKey:@"picture_url"];
                        
                        [user save];
                    }
                }];
                
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
        NSLog(@"twitter button pressed");
        [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Twitter login.");
                return;
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in with Twitter!");
                
                // TODO: Populate Account w/ Information
                self.feedViewController = [[MASFeedViewController alloc] initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]];
                [self presentViewController:self.feedViewController animated:YES completion:nil];
            } else {
                NSLog(@"User logged in with Twitter!");
                self.feedViewController = [[MASFeedViewController alloc] initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]];
                [self presentViewController:self.feedViewController animated:YES completion:nil];
            }     
        }];
    } else if(sender == self.loginButton) {
        NSLog(@"login button pressed");
        
        NSString *username = [self.usernameTextField.text lowercaseString];
        NSString *password = self.passwordTextField.text;
        [PFUser logInWithUsernameInBackground:username password:password
            block:^(PFUser *user, NSError *error) {
                if (user) {
                    self.feedViewController = [[MASFeedViewController alloc] initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]];
                    [self presentViewController:self.feedViewController animated:YES completion:nil];
                } else {
                    // TODO: Print a better error message when the login fails
                }
            }];
        
    } else if(sender == self.forgotPasswordButton) {
        NSLog(@"forgot password button pressed");
        
        // TODO: Add forgot user sequence
    } else if(sender == self.signupButton) {
        NSLog(@"sign up button pressed");
        
        // Present the sign up view controller
        self.signUpViewController = [[MASSignUpViewController alloc] initWithNibName:@"MASSignUpViewController"
                                                                              bundle:[NSBundle mainBundle]];
        self.signUpViewController.delegate = self;
        [self presentViewController:self.signUpViewController animated:YES completion:nil];
        
    }
}

- (IBAction)didBeginEditingTextField:(UITextField *)sender
{
    [UIView animateWithDuration:0.3 animations: ^ {
        self.view.frame = CGRectMake(0, -164, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }];
}

- (IBAction)didEndEditingTextField:(UITextField *)sender
{
//    [self resetViewFrame];
//    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self resetViewFrame];
    return YES;
}

- (void)resetViewFrame
{
    [UIView animateWithDuration:0.3 animations: ^ {
        self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }];
}

- (void)dismissSignUpViewController
{
    [self.signUpViewController dismissViewControllerAnimated:YES completion:^ {
        if ([PFUser currentUser]) {
            self.feedViewController = [[MASFeedViewController alloc] initWithNibName:@"MASFeedViewController" bundle:[NSBundle mainBundle]];
            [self presentViewController:self.feedViewController animated:YES completion:nil];
        }
    }];
}

@end
