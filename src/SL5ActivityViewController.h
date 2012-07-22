//
//  SL5ActivityViewController.h
//  Kawanet iOS-FB Test
//
//  Created by Yusuke Kawasaki on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

typedef void (^SL5ActivityViewControllerCompletionHandler)(NSString *activityType, BOOL completed);

@interface SL5ActivityViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    
}

- (id)initWithActivityItems:(NSArray *)activityItems applicationActivities:(NSArray *)applicationActivities;
@property(nonatomic,copy) SL5ActivityViewControllerCompletionHandler completionHandler;
@property(nonatomic,copy) NSArray *excludedActivityTypes;
@property(nonatomic,copy) NSArray *activityItems;
@property(nonatomic,copy) NSArray *applicationActivities;
@end

NSString *const SL5ActivityTypeFacebook;
NSString *const SL5ActivityTypeTwitter;
NSString *const SL5ActivityTypeMail;

NSString *const SL5ActivityTypeAssignToContact;
NSString *const SL5ActivityTypeCopyToPasteboard;
NSString *const SL5ActivityTypeMessage;
NSString *const SL5ActivityTypePostToWeibo;
NSString *const SL5ActivityTypePrint;
NSString *const SL5ActivityTypeSaveToCameraRoll;
