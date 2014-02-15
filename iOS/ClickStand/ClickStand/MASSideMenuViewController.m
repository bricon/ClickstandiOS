//
//  UTCSSideMenuViewController.m
//  UTCS
//
//  Created by Comyar Zaheri on 2/12/14.
//  Copyright (c) 2014 UTCS. All rights reserved.
//

#import "MASSideMenuViewController.h"


#pragma mark - UTCSSideMenuViewController Class Extension

@interface MASSideMenuViewController ()

//
@property (strong, nonatomic) UIPanGestureRecognizer    *panGestureRecognizer;

@property (assign, nonatomic) BOOL                      menuVisible;

@property (assign, nonatomic) CGPoint                   originalPanPoint;

@end


#pragma mark - UTCSSideMenuViewController Implementation

@implementation MASSideMenuViewController

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithContentController:nil menuController:nil];
}

- (instancetype)initWithContentController:(UIViewController *)contentController menuController:(UIViewController *)menuController
{
    if(self = [super initWithNibName:nil bundle:nil]) {
        _contentController  = contentController;
        _menuController     = menuController;
    }
    return self;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self displayChildViewController:self.menuController];
    [self displayChildViewController:self.contentController];
    
    self.menuController.view.alpha = 0.0;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    self.panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

#pragma mark Presenting Menu Controller

- (void)presentMenuController
{
    self.menuController.view.frame = self.view.bounds;
    
    [self.view.window endEditing:YES];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentController.view.center = CGPointMake(1.25 * CGRectGetWidth(self.view.bounds), self.view.center.y);
        self.menuController.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.menuVisible = YES;
    }];
}

- (void)hideMenuController
{
    [UIView animateWithDuration:0.3f animations:^{
        self.contentController.view.frame = self.view.bounds;
        self.menuController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.menuVisible = NO;
    }];
}

#pragma mark Pan Gesture Recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer translationInView:self.view];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.originalPanPoint = point;
        [self.view.window endEditing:YES];
    } else if(gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat delta = point.x - self.originalPanPoint.x;
        if(point.x > 0.8 * CGRectGetWidth(self.view.bounds)) {
            delta = 0.0;
        }
        if(self.contentController.view.bounds.origin.x + delta < 0.8 * CGRectGetWidth(self.view.bounds) &&
           self.contentController.view.bounds.origin.x + delta > 0.0) {
            self.contentController.view.frame = CGRectMake(self.originalPanPoint.x + delta, self.contentController.view.frame.origin.y, CGRectGetWidth(self.contentController.view.bounds), CGRectGetHeight(self.contentController.view.bounds));
            NSLog(@"%f", self.contentController.view.frame.origin.x);
        }
    } else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([gestureRecognizer velocityInView:self.view].x > 0) {
            [self presentMenuController];
        } else {
            [self hideMenuController];
        }
    }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([self.contentController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self.contentController;
        if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && !self.menuVisible) {
        if ([touch locationInView:gestureRecognizer.view].x > 30) {
            return NO;
        }
        return YES;
    }
    return YES;
}

#pragma mark Displaying Child View Controllers

- (void)displayChildViewController:(UIViewController *)childViewController
{
    childViewController.view.frame = self.view.frame;
    [self addChildViewController:childViewController];
    [self.view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
}

- (void)hideChildViewController:(UIViewController *)childViewController
{
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}

@end
