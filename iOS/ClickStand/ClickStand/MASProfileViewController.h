//
//  MASProfileViewController.h
//  ClickStand
//
//  Created by briyonce on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASProfileViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UITextField *basicInfo;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;

@end
