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

@interface MASFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MASAddPostViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MASAddPostViewController *addPostViewController;

@property NSArray * feedData;

@end
