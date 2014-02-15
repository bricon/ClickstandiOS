//
//  MASDonateViewController.m
//  ClickStand
//
//  Created by briyonce on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASDonateViewController.h"
#import "MASPaymentViewController.h"

@interface MASDonateViewController ()

@end

@implementation MASDonateViewController

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
    
    self.title = @"Donate";
    
    UIButton *donateExisting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //set the position of the button
    donateExisting.frame = CGRectMake(self.view.frame.origin.x + 16, self.view.frame.origin.y + 150, CGRectGetWidth(self.view.bounds) - 32, 44);
    [donateExisting setTitle:@"Use an existing card" forState:UIControlStateNormal];
    [donateExisting addTarget:self action:@selector(donateWithExistingCard) forControlEvents:UIControlEventTouchUpInside];
    donateExisting.backgroundColor= [UIColor clearColor];
    donateExisting.layer.borderColor = [UIColor greenColor].CGColor;
    donateExisting.layer.borderWidth = 1.0;
    donateExisting.layer.cornerRadius = 5.0;
    [donateExisting setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:donateExisting];
    
    
    UIButton *donateNew = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //set the position of the button
    donateNew.frame = CGRectMake(self.view.frame.origin.x + 16, self.view.frame.origin.y + 210, CGRectGetWidth(self.view.bounds) - 32, 44);
    [donateNew setTitle:@"Use a new card" forState:UIControlStateNormal];
    [donateNew addTarget:self action:@selector(donateWithNewCard) forControlEvents:UIControlEventTouchUpInside];
    donateNew.backgroundColor= [UIColor clearColor];
    donateNew.layer.borderColor = [UIColor greenColor].CGColor;
    donateNew.layer.borderWidth = 1.0;
    donateNew.layer.cornerRadius = 5.0;
    [donateNew setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:donateNew];


}

-(void)donateWithExistingCard{
    
}

-(void)donateWithNewCard{
    MASPaymentViewController * paymentViewController = [[MASPaymentViewController alloc] init];
    [self.navigationController pushViewController:paymentViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
