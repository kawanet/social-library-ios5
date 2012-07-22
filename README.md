SL5 - Social Library for iOS5
=============================

SL5 is a library designed for iOS5 apps.
SL5ComposeViewController class presents a view to the user to compose a post for both of social networking services: twitter and Facebook.
SL5ActivityViewController class provides super easy way for developers to show an ActionSheet to dispatch.
You don't need to wait until iOS6 released to implement the "Share" button on your app!

SYNOPSYS
--------
    
    NSString *text = @"Hello, iOSDevCamp!";
    NSURL *url = [NSURL URLWithString:@"http://www.iosdevcamp.org/"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];

    NSArray *activityItems = [NSArray arrayWithObjects:text, url, image, nil];
    NSArray *applicationActivities = nil;
    SL5ActivityViewController *activityVC = [[SL5ActivityViewController alloc]initWithActivityItems:activityItems
                                            applicationActivities:applicationActivities];
    activityVC.excludedActivityTypes = nil;
    
    activityVC.completionHandler = ^(NSString *activityType, BOOL completed){
        if (completed) {
            NSLog(@"Posted: %@", activityType);
        } else {
            NSLog(@"Cancelled: %@", activityType);
        }
        [activityVC dismissViewControllerAnimated:YES completion:nil];
    };

    [self presentViewController:activityVC animated:YES completion:nil];
