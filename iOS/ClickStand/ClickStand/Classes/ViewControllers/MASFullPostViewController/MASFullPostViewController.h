//
//  MASFullPostViewController.h
//  ClickStand
//
//  Created by briyonce on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASFullPostViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView           *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView            *image;
@property (weak, nonatomic) IBOutlet UILabel                *postTitle;
@property (weak, nonatomic) IBOutlet UITextView             *description;
@property (weak, nonatomic) IBOutlet UIImageView            *userImage;
@property (strong, nonatomic) NSString                      *userID;

@property (weak, nonatomic) UIImageView                     *postImage;
@property (weak, nonatomic) PFObject                        *userObj;


// Added this to load faster
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPfObj:(PFObject *) object andImage:(UIImageView *)image;

@end
