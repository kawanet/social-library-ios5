//
//  SL5ActivityViewController.m
//  Kawanet iOS-FB Test
//
//  Created by Yusuke Kawasaki on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SL5ActivityViewController.h"

@interface SL5ActivityViewController ()
@end

@implementation SL5ActivityViewController

@synthesize applicationActivities;
@synthesize completionHandler;
@synthesize activityItems;
@synthesize excludedActivityTypes;

NSString *activityText;
NSURL *activityURL;
UIImage *activityImage;

static NSString * const kOKButton = @"OK";
static NSString * const kCancelButton = @"Cancel";
static NSString * const kFacebookButton = @"Facebook";
static NSString * const kFacebookWallButton = @"Facebook Wall";
static NSString * const kFacebookPhotosButton = @"Facebook Photos";
static NSString * const kTwitterButton = @"Twitter";
static NSString * const kMailButton = @"Mail";
static NSString * const kCameraButton = @"Camera";
static NSString * const kCameraRollButton = @"Camera Roll";

-(void)loadView{
    NSLog(@"loadView:");
    
    UIView *myView = [[UIView alloc]init];
    // UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    myView.backgroundColor = [UIColor clearColor];
    myView.opaque = YES;
    [myView setBackgroundColor:[UIColor clearColor]];
    [myView setOpaque:NO];
    self.view = myView;
    NSLog(@"loadView: backgroundColor=%@", self.view.backgroundColor);
}

- (void)showErrorDialog:(NSString*)title message:(NSString*)message {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

BOOL appearDone = NO;

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear:");
    [super viewDidAppear:(BOOL)animated];

    if (appearDone) {
        return;
    }
    appearDone =YES;
    
    NSLog(@"viewDidAppear: backgroundColor=%@", self.view.backgroundColor);
    
    for(id item in self.activityItems){
        NSURL *url = item;
        NSString *text = item;
        UIImage *image = item;
        if (image) {
            activityImage = image;
            NSLog(@"viewDidAppear: Image=%@", image);
        } else if (url) {
            activityURL = url;
            NSLog(@"viewDidAppear: URL=%@", url);
        } else if (text) {
            activityText = text;
            NSLog(@"viewDidAppear: Text=%@", text);
        } else {
            NSLog(@"Unsupported media type: %@", item);
        }
    }
    
    UIActionSheet *sheet =[[UIActionSheet alloc] init];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    sheet.delegate = self;
    [sheet addButtonWithTitle:kFacebookButton];
    [sheet addButtonWithTitle:kTwitterButton];
    [sheet addButtonWithTitle:kMailButton];
    [sheet addButtonWithTitle:kCancelButton];
    sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"actionSheet: clickedButtonAtIndex buttonIndex=%i", buttonIndex);

    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        NSLog(@"actionSheet: CancelButton");
        
    } else {
        NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
        NSLog(@"actionSheet: buttonIndex=%d %@", buttonIndex, title);
        if ([title isEqualToString:kFacebookButton]) {
            [self facebookButtonClicked:nil];
        } else if ([title isEqualToString:kTwitterButton]) {
            [self tweetButtonClicked:nil];
        } else if ([title isEqualToString:kMailButton]) {
            [self mailButtonClicked:nil];
        }
    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"actionSheet: didDismissWithButtonIndex buttonIndex=%i", buttonIndex);
    [self closeView];
}

- (void)closeView {
    NSLog(@"closeView:");
    appearDone = NO;
    [self dismissModalViewControllerAnimated:FALSE];
}

- (IBAction)facebookButtonClicked:(id)sender {
    NSLog(@"facebookButtonClicked:");
}

- (IBAction)tweetButtonClicked:(id)sender {
    NSLog(@"tweetButtonClicked: 1");  
    
    /*
    if (! [TWTweetComposeViewController canSendTweet]) {
        [self showErrorDialog:@"Sorry" message:@"Twitter composer not available"];
        return;
    }
    */
    
    NSLog(@"tweetButtonClicked: 2");  
    NSString *photoTitle = activityText;
    NSString *photoURL = [activityURL absoluteString];
    
    NSString *body;
    if (photoTitle && photoURL) {
        body = [NSString stringWithFormat:@"%@\n%@", photoTitle, photoURL];
    } else if (photoTitle) {
        body = photoTitle;
    } else if (photoURL) {
        body = photoURL;
    } else {
        body = @"";
    }
    
    NSLog(@"tweetButtonClicked: 3");  
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
    NSLog(@"tweetButtonClicked: 4");  
    [tweetSheet setInitialText:body];
    [tweetSheet addImage: activityImage];
    
    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        dispatch_queue_t main_queue = dispatch_get_main_queue();
        dispatch_async(main_queue, ^{
            if (res == TWTweetComposeViewControllerResultDone) {
                NSLog(@"completionHandler: succeeded.");
            } else if (res == TWTweetComposeViewControllerResultCancelled) {
                NSLog(@"completionHandler: canceled.");
            }
            [self closeView];
        });
    };
    
    NSLog(@"tweetButtonClicked: 5");  
    [self presentModalViewController:tweetSheet animated:YES];
    NSLog(@"tweetButtonClicked: 6");  
}
- (IBAction)mailButtonClicked:(id)sender {
    NSLog(@"mailButtonClicked:");
    if (! [MFMailComposeViewController canSendMail]) {
        [self showErrorDialog:@"Sorry" message:@"Mail composer not available"];
        return;
    }
    NSString *photoTitle = activityText;
    NSString *photoURL = [activityURL absoluteString];

    MFMailComposeViewController *mailSheet = [[MFMailComposeViewController alloc] init];
    NSString *body;
    if (photoTitle && photoURL) {
        body = [NSString stringWithFormat:@"%@\n%@", photoTitle, photoURL];
    } else if (photoTitle) {
        body = photoTitle;
    } else if (photoURL) {
        body = photoURL;
    } else {
        body = @"";
    }
                      
    mailSheet.mailComposeDelegate = self;
    [mailSheet setMessageBody:body isHTML:NO];
    
    if (activityImage) {
        CGFloat compressionQuality = 0.7;
        NSData *attachData = UIImageJPEGRepresentation(activityImage, compressionQuality);
        [mailSheet addAttachmentData:attachData
                            mimeType:@"image/jpeg"
                            fileName:@"photo.jpg"];
    }

    [self presentModalViewController:mailSheet animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    NSLog(@"mailComposeController: didFinishWithResult=%@", result);
    [controller dismissViewControllerAnimated:YES
                                   completion:^{
                                       NSLog(@"mailComposeController: completion");
                                       [self closeView];
                                   }]; 
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear:");
    [super viewDidDisappear:(BOOL)animated];
}

- (void)viewDidUnload
{
    NSLog(@"viewDidUnload:");
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// ------

- (id)initWithActivityItems:(NSArray *)_activityItems applicationActivities:(NSArray *)_applicationActivities
{
    NSLog(@"initWithActivityItems");
    self = [super init];
    if (self) {
        self.activityItems = _activityItems;
        self.applicationActivities = _applicationActivities;
    }
    return self;
}
@end
