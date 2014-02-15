//
//  MASFullPostViewController.m
//  ClickStand
//
//  Created by briyonce on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASFullPostViewController.h"
#import "MASProfileViewController.h"

@interface MASFullPostViewController ()

@end

@implementation MASFullPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedProfileImage)];
    profileTap.numberOfTapsRequired = 1;
    self.userImage.userInteractionEnabled = YES;
    [self.userImage addGestureRecognizer:profileTap];
    
}

-(void)tapDetectedProfileImage{
    NSLog(@"single tap on profile image");
    //load profile
    MASProfileViewController * profileViewController = [[MASProfileViewController alloc] init];
    [self.navigationController pushViewController:profileViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
