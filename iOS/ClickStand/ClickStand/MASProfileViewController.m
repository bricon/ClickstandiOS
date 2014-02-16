//
//  MASProfileViewController.m
//  ClickStand
//
//  Created by briyonce on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASProfileViewController.h"
#define kOFFSET_FOR_KEYBOARD 150

@interface MASProfileViewController ()
@property BOOL stayup;
@property (strong, nonatomic) UIBarButtonItem   *editBarButtonItem;
@end

@implementation MASProfileViewController

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
    self.title = @"Profile";
    self.name.enabled = NO;
    self.description.editable = NO;
    self.basicInfo.enabled = NO;
    
    self.name.delegate = self;
    self.description.delegate  = self;
    self.basicInfo.delegate = self;
  
    self.profileImage.layer.cornerRadius = 50.0;
    self.profileImage.layer.masksToBounds = YES;
    
    self.editBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    self.navigationItem.rightBarButtonItem = self.editBarButtonItem;
    
    self.postsCollectionView.dataSource = self;
    self.postsCollectionView.delegate = self;
    
    [self.postsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PostCollectionViewCell"];
}

-(void)saveInfo:(id)sender{
    NSLog(@"save info");
    //make things uneditable
    //send that shit back to parse
}

//shit to move the view up with the keyboard
//NOT A GOOD WAY TO DO THIS IN THE LONG RUN

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"yo yo yo");
    if (textField == self.name) {
        NSLog(@"wassaup");
        [self.name becomeFirstResponder];
    } else if(textField == self.basicInfo){
        [self.basicInfo becomeFirstResponder];
    }
    
    return YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    if(!cell) {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
    }
    
    cell.backgroundColor = [UIColor redColor];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    imageView.image = [UIImage imageNamed:@"puppy.jpg"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        
        if (rect.origin.y == 0 ) {
            rect.origin.y -= kOFFSET_FOR_KEYBOARD;
            //rect.size.height += kOFFSET_FOR_KEYBOARD;
        }
        
    }
    else
    {
        if (_stayup == NO) {
            rect.origin.y += kOFFSET_FOR_KEYBOARD;
            //rect.size.height -= kOFFSET_FOR_KEYBOARD;
        }
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [self setViewMovedUp:NO];
}


- (void)keyboardWillShow:(NSNotification *)notif{
    [self setViewMovedUp:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.stayup = YES;
    [self setViewMovedUp:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.stayup = NO;
    [self setViewMovedUp:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
