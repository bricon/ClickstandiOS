//
//  MASSignUpViewController.h
//  ClickStand
//
//  Created by Matthew Ebeweber on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MASSignUpViewControllerDelegate <NSObject>

@required // required is the default
- (void)dismissSignUpViewController;

@end

@interface MASSignUpViewController : UIViewController

@property (weak, nonatomic) id<MASSignUpViewControllerDelegate> delegate;

- (IBAction)didTouchUpInsideButton:(UIButton *)sender;
- (IBAction)didEndEditingTextField:(UITextField *)sender;

- (IBAction)comyarFixMe:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationTextField;
@property (weak, nonatomic) IBOutlet UIButton *returnToLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end
