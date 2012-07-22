SL5 - Social Library for iOS5
=============================

SL5 is a library designed for iOS5 apps.
`SL5ComposeViewController` class presents a view to the user to compose a post for both of social networking services: twitter and Facebook.
`SL5ActivityViewController` class provides super easy way for developers to show an ActionSheet to dispatch.
You don't need to wait until iOS6 released to implement the "Share" button on your app!

SYNOPSYS
--------
    
    NSString *text = @"Hello, iOSDevCamp!";
    NSURL *url = [NSURL URLWithString:@"http://www.iosdevcamp.org/"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];

    NSArray *activityItems = [NSArray arrayWithObjects:text, url, image, nil];
    SL5ActivityViewController *activityVC = [[SL5ActivityViewController alloc]initWithActivityItems:activityItems
                                            applicationActivities:nil];
    
    activityVC.completionHandler = ^(NSString *activityType, BOOL completed){
        if (completed) {
            NSLog(@"Posted: %@", activityType);
        } else {
            NSLog(@"Cancelled: %@", activityType);
        }
        [activityVC dismissViewControllerAnimated:YES completion:nil];
    };

    [self presentViewController:activityVC animated:YES completion:nil];

AUTHOR
------

[@kawanet](http://twitter.com/kawanet) Yusuke Kawasaki

MIT LICENSE
----------

Copyright (c) 2012 Yusuke Kawasaki

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
