//
//  MASFeedViewController.h
//  ClickStand
//
//  Created by briyonce on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MASAddPostViewController.h>
#import <QuartzCore/QuartzCore.h>
#import "BTPaymentViewController.h"

@interface MASFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MASAddPostViewControllerDelegate, BTPaymentViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MASAddPostViewController *addPostViewController;

@property NSArray * feedData;

@property BTPaymentViewController *paymentViewController;

@end
