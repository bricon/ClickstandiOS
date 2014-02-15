//
//  MASHomeViewController.m
//  ClickStand
//
//  Created by Comyar Zaheri on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASHomeViewController.h"
#import "MASLoginViewController.h"

@interface MASHomeViewController ()
@property (strong, nonatomic) MASLoginViewController *loginViewController;
@end

@implementation MASHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
