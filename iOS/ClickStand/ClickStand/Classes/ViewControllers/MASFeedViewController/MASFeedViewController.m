//
//  MASFeedViewController.m
//  ClickStand
//
//  Created by briyonce on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASFeedViewController.h"
#import "MASFeedCell.h"

@interface MASFeedViewController ()

@end

@implementation MASFeedViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    //make call to update the table
    
    // If the user is not logged in we simply return nothing
    if (![PFUser currentUser]) {
        return;
    }
    
    // Query to get all posts by current user
    PFQuery *postsFromCurrentUser = [PFQuery queryWithClassName:@"Post"];
    [postsFromCurrentUser whereKey:@"createdBy" equalTo:[PFUser currentUser]];
    [postsFromCurrentUser orderByDescending:@"createdAt"];
    self.feedData = postsFromCurrentUser;
    NSLog(@"feedData : %@", self.feedData);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: change to pull actual feed
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *feedcell = @"feedCell";
    
    MASFeedCell *cell = (MASFeedCell *)[tableView dequeueReusableCellWithIdentifier:feedcell];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MASFeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    return cell;

}


@end
