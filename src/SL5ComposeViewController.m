//
//  SL5ComposeViewController.m
//  Kawanet iOS-FB Test
//
//  Created by Yusuke Kawasaki on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SL5ComposeViewController.h"

@interface SL5ComposeViewController ()

@end

NSString *_serviceType;

@implementation SL5ComposeViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// ----------------

+ (SL5ComposeViewController *)composeViewControllerForServiceType:(NSString *)serviceType {
    _serviceType = serviceType;
    SL5ComposeViewController *vc = [[self alloc] init];
    return vc;
}

+ (BOOL)isAvailableForServiceType:(NSString *)serviceType {
    return YES;
}

- (BOOL)addImage:(UIImage *)image {
    return YES;
}

- (BOOL)addURL:(NSURL *)url {
    return YES;
}

- (BOOL)removeAllImages {
    return YES;
}

- (BOOL)removeAllURLs {
    return YES;
}

- (BOOL)setInitialText:(NSString *)text {
    return YES;
}

// ----------------

@end
