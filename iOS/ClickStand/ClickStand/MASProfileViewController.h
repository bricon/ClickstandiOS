//
//  MASProfileViewController.h
//  ClickStand
//
//  Created by briyonce on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *basicInfo;
@property (weak, nonatomic) IBOutlet UITextView *description;

@end
