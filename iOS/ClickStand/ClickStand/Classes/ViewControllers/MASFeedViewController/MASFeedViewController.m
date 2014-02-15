//
//  MASFeedViewController.m
//  ClickStand
//
//  Created by briyonce on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASFeedViewController.h"
#import "MASFeedCell.h"
#import "MASFullPostViewController.h"
#import "MASProfileViewController.h"
#import "MASPaymentViewController.h"
#import "MASSideMenuViewController.h"
#import "MASAppDelegate.h"
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
    
    
    UIBarButtonItem *addPostButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
 
                                                                                   action:@selector(plusButtonPressed:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = addPostButton;
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = menuButton;
}

- (void)menuButtonPressed:(id)sender
{
    MASSideMenuViewController *sideMenuViewController = ((MASAppDelegate *)[[UIApplication sharedApplication]delegate]).sideMenuViewController;
    if(sideMenuViewController.menuVisible) {
        [sideMenuViewController hideMenuController];
    } else {
        [sideMenuViewController presentMenuController];
    }
}

-(void)plusButtonPressed:(id)sender
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    //make call to update the table
    
    // If the user is not logged in we simply return nothing
    if (![PFUser currentUser]) {
        return;
    }
    
    
    //get all posts
    [self getFeedDataFromParse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getFeedDataFromParse{
    //get all posts
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query setLimit:1000];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu posts.", (unsigned long)objects.count);
            self.feedData = objects;
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.feedData.count ==0){
        NSLog(@"yo nothing is populated");
        return 5;
    }
    return self.feedData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *feedcell = @"feedCell";
    
    MASFeedCell *cell = (MASFeedCell *)[tableView dequeueReusableCellWithIdentifier:feedcell];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MASFeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        //add parse data into cell
        //commented out because no posts have been made
        //NSDictionary * post = self.feedData[indexPath.row];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedMainImage:)];
        singleTap.numberOfTapsRequired = 1;
        cell.image.userInteractionEnabled = YES;
        
        [cell.image addGestureRecognizer:singleTap];
        //add post ID tag so we can get post info in the next view
        
        UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedProfileImage:)];
        profileTap.numberOfTapsRequired = 1;
        cell.userImage.userInteractionEnabled = YES;
        [cell.userImage addGestureRecognizer:profileTap];
        //add user ID tag so we can get profile info in the next view
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //set the position of the button
        button.frame = CGRectMake(cell.frame.origin.x + 16, cell.frame.origin.y + 444, CGRectGetWidth(self.view.bounds) - 32, 44);
        [button setTitle:@"Donate" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(donate:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor= [UIColor clearColor];
        button.layer.borderColor = [UIColor greenColor].CGColor;
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 5.0;
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:button];
    }
    
    cell.image.layer.cornerRadius = 4.0;
    cell.image.layer.masksToBounds = YES;
    
    cell.userImage.layer.cornerRadius = 5.0;
    cell.userImage.layer.masksToBounds = YES;
    
    return cell;

}

-(void)tapDetectedMainImage:(id) sender{
    NSLog(@"single Tap on imageview");
    //load full post page
    MASFullPostViewController * fullPostViewController = [[MASFullPostViewController alloc] init];
    [self.navigationController pushViewController:fullPostViewController animated:YES];
}

-(void)tapDetectedProfileImage:(id) sender{
    NSLog(@"single tap on profile image");
    //load profile
    MASProfileViewController * profileViewController = [[MASProfileViewController alloc] init];
    [self.navigationController pushViewController:profileViewController animated:YES];
}

-(void)donate:(id) sender{
    NSLog(@"donate");
    //payment stuff
    MASPaymentViewController * paymentViewController = [[MASPaymentViewController alloc] init];
    [self.navigationController pushViewController:paymentViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: modify height to message length
    return 500;
}


@end
