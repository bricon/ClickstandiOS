//
//  MASLogin.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASLoginViewController.h"

@implementation MASLoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (IBAction)didTouchUpInsideButton:(UIButton *)sender
{
    if(sender == self.facebookLoginButton) {
        // TODO Login with Facebook
    } else if(sender == self.twitterLoginButton) {
        // TODO Login with Twitter
    }
}
@end
