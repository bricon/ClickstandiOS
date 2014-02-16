//
//  MASAddPostViewController.m
//  ClickStand
//
//  Created by Matthew Ebeweber on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASAddPostViewController.h"

@interface MASAddPostViewController ()

@end

@implementation MASAddPostViewController

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
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Device has no camera"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
        [alert show];
    }

    self.postTitleTextField.delegate = self;
    self.postBodyTextField.delegate  = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.postTitleTextField) {
        [self.postBodyTextField becomeFirstResponder];
    } else if (textField == self.postBodyTextField) {
        [self.postBodyTextField resignFirstResponder];
    }
    
    return YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchUpInsideButton:(UIButton *)sender
{
    if (sender == self.submitPostButton) {
        NSLog(@"Creating a new post");
        NSString *title = self.postTitleTextField.text;
        NSString *body  = self.postBodyTextField.text;
        
        if ([self.postTitleTextField.text isEqualToString:@""]) {
            [self throwMissingFieldsAlert];
        } else if ([self.postBodyTextField.text isEqualToString:@""]) {
            [self throwMissingFieldsAlert];
        } else if (self.postImageView.image == nil) {
            [self throwMissingFieldsAlert];
        } else {
        
            PFObject *newPost = [PFObject objectWithClassName:@"Post"];
            newPost[@"title"] = title;
            newPost[@"description"] = body;
            
            // Set the image a bit differently
            PFFile *imageFile = [PFFile fileWithData:UIImagePNGRepresentation(self.postImageView.image)];
            newPost[@"image"] = imageFile;
            
            newPost[@"created_by"] = [PFObject objectWithoutDataWithClassName:@"_User"
                                            objectId:[PFUser currentUser].objectId];
            
            newPost[@"money_raised"] = [NSNumber numberWithInt:0];
            newPost[@"num_stands"]   = [NSNumber numberWithInt:0];
            
            [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                    message:@"Made a stand!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Something went wrong. Please try again."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
    }
}

- (void)throwMissingFieldsAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Please fill in all the fields and make sure you have added a picture."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)selectPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.postImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
