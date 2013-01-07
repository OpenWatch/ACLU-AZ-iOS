//
//  OWAboutViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/4/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWAboutViewController.h"
#import "OWACLUAZStrings.h"
#import "OWACLUAZUtilities.h"

@interface OWAboutViewController ()

@end

@implementation OWAboutViewController
@synthesize acluButton, openwatchButton, aboutTextView, poweredByLabel;

- (id)init
{
    self = [super init];
    if (self) {

        self.title = ABOUT_STRING;
        self.aboutTextView = [[UITextView alloc] init];
        self.poweredByLabel = [[UILabel alloc] init];
        [self.view addSubview:poweredByLabel];
        [self.view addSubview:aboutTextView];
        self.view.backgroundColor = [OWACLUAZUtilities backgroundPattern];
        [self setupBanners];
    }
    return self;
}

- (void) setupBanners {
    UIImage *acluImage = [UIImage imageNamed:@"aclu-logo.jpg"];
    UIImage *openwatchImage = [UIImage imageNamed:@"openwatch.png"];
    self.acluButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openwatchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [acluButton setImage:acluImage forState:UIControlStateNormal];
    self.acluButton.frame = CGRectMake(0, 0, acluImage.size.width, acluImage.size.height);
    [openwatchButton setImage:openwatchImage forState:UIControlStateNormal];
    
    openwatchButton.imageView.contentMode = UIViewContentModeCenter;
    
    [self.view addSubview:acluButton];
    [self.view addSubview:openwatchButton];
    
    [OWACLUAZUtilities setShadowForView:acluButton];
    [OWACLUAZUtilities setShadowForView:openwatchButton];
    
    [openwatchButton addTarget:self action:@selector(openwatchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [acluButton addTarget:self action:@selector(acluButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.aboutTextView.text = ABOUT_MESSAGE_STRING;
    self.aboutTextView.editable = NO;
    self.poweredByLabel.text = POWERED_BY_STRING;
    [self styleTextForTextView:aboutTextView];
    [self styleLabel:poweredByLabel];
}

- (void) styleTextForTextView:(UITextView*)textView {
    textView.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    textView.textColor = [UIColor whiteColor];
    textView.backgroundColor = [UIColor clearColor];
}

- (void) styleLabel:(UILabel*)label {
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.textAlignment = UITextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat bannerHeight = 138.0f;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat padding = 10.0f;
    CGFloat bottomViewHeight = 60.0f;

    self.acluButton.frame = CGRectMake(padding, padding*2, width-padding*2, bannerHeight);
    self.aboutTextView.frame = CGRectMake(padding, [OWACLUAZUtilities bottomOfView:acluButton], width-padding*2, height - [OWACLUAZUtilities bottomOfView:acluButton] - bottomViewHeight);
    self.aboutTextView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    self.poweredByLabel.frame = CGRectMake(padding, [OWACLUAZUtilities bottomOfView:aboutTextView], width/2-padding*2, bottomViewHeight);
    self.openwatchButton.frame = CGRectMake([OWACLUAZUtilities rightOfView:poweredByLabel], [OWACLUAZUtilities bottomOfView:aboutTextView], 150, bottomViewHeight);
    self.poweredByLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.openwatchButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

- (void) openwatchButtonPressed:(id)sender {
    NSURL *openwatchURL = [NSURL URLWithString:@"http://www.openwatch.net"];
    [[UIApplication sharedApplication] openURL:openwatchURL];
}

- (void) acluButtonPressed:(id)sender {
    NSURL *acluURL = [NSURL URLWithString:@"http://www.acluaz.org"];
    [[UIApplication sharedApplication] openURL:acluURL];
}

@end
