//
//  MASPaymentViewController.m
//  ClickStand
//
//  Created by briyonce on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASPaymentViewController.h"

@interface MASPaymentViewController ()

@end

@implementation MASPaymentViewController

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
    //test key for now, change to publisable key later
    self.stripeView = [[STPView alloc] initWithFrame:CGRectMake(15,20,290,55)
                                              andKey:@"pk_test_pchEhEqli57yAGBQhMxxe1PS"];
    self.stripeView.delegate = self;
    [self.view addSubview:self.stripeView];
}

- (void)stripeView:(STPView *)view withCard:(PKCard *)card isValid:(BOOL)valid
{
    // Toggle navigation, for example
    // self.saveButton.enabled = valid;
    
//    When all the card data is added and valid the stripeView:withCard:isValid: delegate method will be called. In the callback, for example, we could enable a 'save button' that allows users to submit their valid cards:
}


- (IBAction)save:(id)sender
{
    // Call 'createToken' when the save button is tapped
    [self.stripeView createToken:^(STPToken *token, NSError *error) {
        if (error) {
            // Handle error
            // [self handleError:error];
        } else {
            // Send off token to your server
            // [self handleToken:token];
        }
    }];}

- (void)handleError:(NSError *)error
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
