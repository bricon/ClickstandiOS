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
  
    
    
    //TODO: check if it's the user's profile
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //set the position of the button
    button.frame = CGRectMake(self.view.frame.origin.x + 200, self.view.frame.origin.y + 465, CGRectGetWidth(self.view.bounds) -230, 20);
    [button setTitle:@"Edit" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(editInfo:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor= [UIColor clearColor];
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5.0;
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    

}


-(void)editInfo:(id)sender{
    NSLog(@"edit info");
    
    //show save button, hide edit
    [sender removeFromSuperview];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.frame.origin.x + 200, self.view.frame.origin.y + 465, CGRectGetWidth(self.view.bounds) -230, 20);
    [button setTitle:@"Save" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor= [UIColor clearColor];
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5.0;
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    self.name.enabled = YES;
    self.description.editable = YES;
    self.basicInfo.enabled = YES;
    
    self.name.backgroundColor = [UIColor grayColor];
    self.basicInfo.backgroundColor = [UIColor grayColor];
    self.description.backgroundColor=[UIColor grayColor];
}

-(void)saveInfo:(id)sender{
    NSLog(@"save info");
    //make things uneditable
    //send that shit back to parse
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
