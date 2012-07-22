//
//  SL5ComposeViewController.h
//  Kawanet iOS-FB Test
//
//  Created by Yusuke Kawasaki on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SL5ComposeViewController : UIViewController

@end

NSString *const SL5ServiceTypeFacebook;
NSString *const SL5ServiceTypeTwitter;
NSString *const SL5ServiceTypeMail;

enum SL5ComposeViewControllerResult {
    SL5ComposeViewControllerResultCancelled,
    SL5ComposeViewControllerResultDone
} SL5ComposeViewControllerResult;
