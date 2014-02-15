//
//  MASAddPostViewController.h
//  ClickStand
//
//  Created by Matthew Ebeweber on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MASAddPostViewControllerDelegate <NSObject>

- (void)dismissAddPostViewController;

@end

@interface MASAddPostViewController : UIViewController <UIImagePickerControllerDelegate,
                                                        UINavigationControllerDelegate>

@property (weak, nonatomic) id<MASAddPostViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *postTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *postBodyTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitPostButton;

// Fields related to taking a picture
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;

- (IBAction)didTouchUpInsideButton:(UIButton *)sender;



@end
