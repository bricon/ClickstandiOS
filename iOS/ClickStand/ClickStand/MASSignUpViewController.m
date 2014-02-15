//
//  MASSignUpViewController.m
//  ClickStand
//
//  Created by Matthew Ebeweber on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASSignUpViewController.h"

@interface MASSignUpViewController ()

@end

@implementation MASSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)didTouchUpInsideButton:(UIButton *)sender
{
    if (sender == self.signUpButton) {
        NSLog(@"User pressed the sign up button");
        
        if (![self.passwordTextField.text  isEqualToString:self.passwordConfirmationTextField.text]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Passwords did not match. Please try again."
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            
            // TODO: Clear appropriate fields
        } else  {
            PFUser *user = [PFUser user];
            
            user.username = [self.emailTextField.text lowercaseString];
            user.email    = [self.emailTextField.text lowercaseString];
            user.password = self.passwordTextField.text;
            
            user[@"name"] = self.fullNameTextField.text;
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [self.delegate dismissSignUpViewController];
                } else {
                    NSString *errorString = [error userInfo][@"error"];
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorString
                                                                        message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"Ok", nil];
                    [alertView show];
                }
            }];
        }
        
    } else if (sender == self.returnToLoginButton) {
        NSLog(@"User pressed the return to login button");
        
        [self.delegate dismissSignUpViewController];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: Comyar is this good form? Didn't work.
- (void)didEndEditingTextField:(UITextView *)textView
{
    NSLog(@"resignFirstResponder");
    [textView resignFirstResponder];
}

- (IBAction)comyarFixMe:(id)sender
{
    [self.view endEditing:YES];
}

@end
