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
#import "MASAddPostViewController.h"
#import "MASPaymentViewController.h"
#import "MASDonateViewController.h"
#import "RESideMenu.h"
#import "MASAppDelegate.h"


@interface MASFeedViewController ()

@end

@implementation MASFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        ///Users/matthewebeweber/Documents/clickstand/iOS/ClickStand/ClickStand/MASAddPostViewController.m Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentSize = self.view.bounds.size;
    
    UIBarButtonItem *addPostButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
 
                                                                                   action:@selector(plusButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addPostButton;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MAS_Logo"]];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
}

- (void)menuButtonPressed:(id)sender
{
    RESideMenu *sideMenuViewController = ((MASAppDelegate *)[[UIApplication sharedApplication]delegate]).sideMenuViewController;
    if(sideMenuViewController.visible) {
        [sideMenuViewController hideMenuViewController];
    } else {
        [sideMenuViewController presentMenuViewController];
    }
}

-(void)plusButtonPressed:(id)sender
{
    self.addPostViewController = [[MASAddPostViewController alloc] init];
    self.addPostViewController.delegate = self;
    [self presentViewController:self.addPostViewController animated:YES completion:nil];
}

-(void)dismissAddPostViewController
{
    [self.addPostViewController dismissViewControllerAnimated:YES completion:nil];
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
            NSLog(@"self.feedData : %@," , self.feedData);
            
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
        return 1;
    }
    return self.feedData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
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
        cell.postImage.layer.cornerRadius = 10.0;
        cell.postImage.layer.masksToBounds = YES;
        [cell.postImage addGestureRecognizer:singleTap];
        //add post ID tag so we can get post info in the next view
        
        UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedProfileImage:)];
        profileTap.numberOfTapsRequired = 1;
        if(cell.userImage)
            NSLog(@"%@", cell.userImage);
        cell.userImage.layer.cornerRadius = 22.5;
        cell.userImage.layer.masksToBounds = YES;
        [cell.userImage addGestureRecognizer:profileTap];
        //add user ID tag so we can get profile info in the next view
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //set the position of the button
        button.frame = CGRectMake(cell.frame.origin.x + 16, cell.frame.origin.y + 444, CGRectGetWidth(self.view.bounds) - 32, 44);
        [button setTitle:@"Donate" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(donate:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor= [UIColor clearColor];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
        button.layer.borderColor = [UIColor colorWithRed:1.000 green:0.333 blue:0.389 alpha:1.000].CGColor;
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 5.0;
        [button setTitleColor:[UIColor colorWithRed:1.000 green:0.333 blue:0.389 alpha:1.000] forState:UIControlStateNormal];
        [cell.contentView addSubview:button];
    }
    
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
//    MASDonateViewController * paymentViewController = [[MASDonateViewController alloc] init];
//    [self.navigationController pushViewController:paymentViewController animated:YES];
    
    //venmo
    self.paymentViewController = [BTPaymentViewController paymentViewControllerWithVenmoTouchEnabled:YES];
    self.paymentViewController.delegate = self;
    [self.navigationController pushViewController:self.paymentViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: modify height to message length
    return 500;
}

//venmo delegate method
- (void)paymentViewController:(BTPaymentViewController *)paymentViewController
        didSubmitCardWithInfo:(NSDictionary *)cardInfo
         andCardInfoEncrypted:(NSDictionary *)cardInfoEncrypted {
    NSLog(@"didSubmitCardWithInfo %@ andCardInfoEncrypted %@", cardInfo, cardInfoEncrypted);
    
    // Make a network request to send the cardInfoEncrypted dictionary from your app to the server.
    // (Sample implementation of this method is below)
    [self savePaymentInfoToServer:cardInfoEncrypted];
}

//venmo delegate method
- (void)paymentViewController:(BTPaymentViewController *)paymentViewController
didAuthorizeCardWithPaymentMethodCode:(NSString *)paymentMethodCode {
    NSLog(@"didAuthorizeCardWithPaymentMethodCode %@", paymentMethodCode);
    // Create a dictionary of POST data of the format
    // {"payment_method_code": "[encrypted payment_method_code data from Venmo Touch client]"}
    NSMutableDictionary *paymentInfo = [NSMutableDictionary dictionaryWithObject:paymentMethodCode
                                                                          forKey:@"venmo_sdk_payment_method_code"];
    
    // Make a network request to send the paymentInfo from your app to the server.
    // (Sample implementation of this method is below)
    [self savePaymentInfoToServer:paymentInfo];
}

//venmo helper method
- (void) savePaymentInfoToServer:(NSDictionary *)paymentInfo {
    NSLog(@"Calling SavePaymentInfoToServer");
    
    
    NSURL *url = [NSURL URLWithString: @"http://http://clickstand.herokuapp.com/card"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // You need a customer id in order to save a card to the Braintree vault.
    // Here, for the sake of example, we set customer_id to device id.
    // In practice, this is probably whatever user_id your app has assigned to this user.
    NSString *customerId = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    [paymentInfo setValue:customerId forKey:@"customer_id"];
    
    //implement this "postDataFromDictionary" thing
    NSData *items = [self postDataFromDictionary:paymentInfo];
    
    // Wasn't working with the body, so we put that shit in the headers
    for (id key in paymentInfo.allKeys) {
        [request addValue:paymentInfo[key] forHTTPHeaderField:key];
    }
    request.HTTPMethod = @"POST";
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *body, NSError *requestError)
     {
         NSError *err = nil;
         NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:body
                                                                            options:kNilOptions error:&err];
         //NSLog(@"saveCardToServer: paymentInfo: %@ response: %@, error: %@",
         //      paymentInfo, responseDictionary, requestError);
         
         if ([[responseDictionary valueForKey:@"success"] isEqualToNumber:@1]) { // Success!
             // Don't forget to call the cleanup method,
             // `prepareForDismissal`, on your `BTPaymentViewController`
             [self.paymentViewController prepareForDismissal];
             
             // Now you can dismiss and tell the user everything worked.
             [self dismissViewControllerAnimated:YES completion:^(void) {
                 [[[UIAlertView alloc] initWithTitle:@"Success"
                                             message:@"Saved your card!" delegate:nil
                                   cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
             }];
             
         } else {
             // Card did not save correctly, so show server error using `showErrorWithTitle:message:`
             [self.paymentViewController
              showErrorWithTitle:@"Error saving your card"
              //implement this
              message:[self messageStringFromResponse:responseDictionary]];
         }
     }];
}



// Construct URL encoded POST data from a dictionary
- (NSData *)postDataFromDictionary:(NSDictionary *)params {
    NSMutableString *data = [NSMutableString string];
    
    for (NSString *key in params) {
        NSString *value = [params objectForKey:key];
        if (value == nil) {
            continue;
        }
        if ([value isKindOfClass:[NSString class]]) {
            value = [self URLEncodedStringFromString:value];
        }
        
        [data appendFormat:@"%@=%@&", [self URLEncodedStringFromString:key], value];
    }
    
    return [data dataUsingEncoding:NSUTF8StringEncoding];
}

// This, from CSKit, is free for use:
// https://github.com/codenauts/CNSKit/blob/master/Classes/Categories/NSString%2BCNSStringAdditions.m
// NSString *encoded = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$&’()*+,;='"), kCFStringEncodingUTF8);

- (NSString *) URLEncodedStringFromString: (NSString *)string {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[string UTF8String];
    size_t sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

// Some boiler plate networking code below.

- (NSString *) messageStringFromResponse:(NSDictionary *)responseDictionary {
    return [responseDictionary valueForKey:@"message"];
}

@end
