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

// Image view displaying the background image behind the menu and content controller
@property (strong, nonatomic) UIImageView               *backgroundImageView;

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
    
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backgroundImageView];
    
    
    [self displayChildViewController:self.menuController];
    [self displayChildViewController:self.contentController];
    
    self.menuController.view.alpha = 0.0;
    [self configureMotionEffectsForViewController:self.menuController];
    
    self.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    self.panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

#pragma mark Presenting Menu Controller

- (void)presentMenuController
{
    self.menuController.view.transform = CGAffineTransformIdentity;
    self.backgroundImageView.transform = CGAffineTransformIdentity;
    self.backgroundImageView.frame = self.view.bounds;
    self.menuController.view.frame = self.view.bounds;
    
    [self.view.window endEditing:YES];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentController.view.center = CGPointMake(1.25 * CGRectGetWidth(self.view.bounds), self.view.center.y);
        self.menuController.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self configureMotionEffectsForViewController:self.contentController];
        self.menuVisible = YES;
    }];
}

- (void)hideMenuController
{
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3f animations:^{
        self.contentController.view.frame = self.view.bounds;
        self.menuController.view.alpha = 0.0;
        for (UIMotionEffect *effect in self.contentController.view.motionEffects) {
            [self.contentController.view removeMotionEffect:effect];
        }
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication]endIgnoringInteractionEvents];
        self.menuVisible = NO;
    }];
}

#pragma mark Pan Gesture Recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    static CGPoint originalPoint = {0,0};
    CGPoint point = [gestureRecognizer translationInView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        originalPoint = CGPointMake(self.contentController.view.center.x - CGRectGetWidth(self.contentController.view.bounds) / 2.0,
                                    self.contentController.view.center.y - CGRectGetHeight(self.contentController.view.bounds) / 2.0);
        self.menuController.view.transform = CGAffineTransformIdentity;
        self.backgroundImageView.transform = CGAffineTransformIdentity;
        self.backgroundImageView.frame = self.view.bounds;
        self.menuController.view.frame = self.view.bounds;
        [self.view.window endEditing:YES];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat delta = self.menuVisible ? (point.x + originalPoint.x) / originalPoint.x : point.x / self.view.frame.size.width;
        if(self.contentController.view.bounds.origin.x + delta > 0.8 * CGRectGetWidth(self.view.bounds)) {
            self.contentController.view.transform = CGAffineTransformTranslate(self.contentController.view.transform, delta, 0);
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
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

#pragma mark Configuring Motion Effects

- (void)configureMotionEffectsForViewController:(UIViewController *)viewController
{
    for(UIMotionEffect *effect in viewController.view.motionEffects) {
        [viewController.view removeMotionEffect:effect];
    }
    
    UIInterpolatingMotionEffect *interpolationHorizontalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolationHorizontalMotionEffect.minimumRelativeValue = @(-15);
    interpolationHorizontalMotionEffect.maximumRelativeValue = @(15);
    
    UIInterpolatingMotionEffect *interpolationVerticalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolationVerticalMotionEffect.minimumRelativeValue = @(-15);
    interpolationVerticalMotionEffect.maximumRelativeValue = @(15);
    
    [viewController.view addMotionEffect:interpolationHorizontalMotionEffect];
    [viewController.view addMotionEffect:interpolationVerticalMotionEffect];
}

#pragma mark Overridden Property Setters

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage                = backgroundImage;
    self.backgroundImageView.image  = backgroundImage;
}

@end
