//
//  MASLogin.h
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASFeedViewController.h"

@interface MASLoginViewController : UIViewController

- (IBAction)didTouchUpInsideButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterLoginButton;

@property (strong, nonatomic) MASFeedViewController *feedViewController;



@end
