//
//  MASFeedCell.h
//  ClickStand
//
//  Created by briyonce on 2/14/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *stands;
@property (weak, nonatomic) IBOutlet UILabel *dollars;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
