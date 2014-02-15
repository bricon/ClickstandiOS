//
//  MASPaymentViewController.h
//  ClickStand
//
//  Created by briyonce on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPView.h"

@interface MASPaymentViewController : UIViewController <STPViewDelegate>
@property STPView* stripeView;
@end
