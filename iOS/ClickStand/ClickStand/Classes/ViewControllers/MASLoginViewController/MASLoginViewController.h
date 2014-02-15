//
//  MASLogin.h
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MASFeedViewController.h"

@interface MASLoginViewController : UIViewController <UITextFieldDelegate>

- (IBAction)didTouchUpInsideButton:(UIButton *)sender;
- (IBAction)didBeginEditingTextField:(UITextField *)sender;
- (IBAction)didEndEditingTextField:(UITextField *)sender;

@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterLoginButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property (strong, nonatomic) MASFeedViewController *feedViewController;



@end
