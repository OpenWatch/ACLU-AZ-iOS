//
//  OWHomeViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import "OWACLUAZHomeViewController.h"
#import "OWUtilities.h"
#import "OWACLUAZStrings.h"

@interface OWACLUAZHomeViewController ()

@end

@implementation OWACLUAZHomeViewController
@synthesize reportButton, bannerImageView, infoButton, rightsButton;

- (id)init
{
    self = [super init];
    if (self) {
        self.bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.jpg"]];
        self.bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.reportButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.view addSubview:bannerImageView];
        [self.view addSubview:reportButton];
        [self.view addSubview:infoButton];
        [self.view addSubview:rightsButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor blueColor];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat bannerHeight = self.view.frame.size.height * 0.3f;
    CGFloat buttonWidth = 200.0f;
    CGFloat buttonHeight = 60.0f;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat padding = 10.0f;
    CGFloat buttonXOrigin = width/2-buttonWidth/2;
    self.bannerImageView.frame = CGRectMake(padding, padding, width-padding*2, bannerHeight);
    self.reportButton.frame = CGRectMake(buttonXOrigin, bannerHeight+padding*2, buttonWidth, buttonHeight);
    self.rightsButton.frame = CGRectMake(buttonXOrigin, [OWUtilities bottomOfView:reportButton]+padding*2, buttonWidth, buttonHeight);
    UIImage *infoImage = [UIImage imageNamed:@"about_icon.png"];
    self.infoButton.frame = CGRectMake(padding, height-infoImage.size.height-padding, infoImage.size.width, infoImage.size.height);
    [self.reportButton setTitle:REPORT_STRING forState:UIControlStateNormal];
    [self.rightsButton setTitle:KNOW_YOUR_RIGHTS_STRING forState:UIControlStateNormal];
    [self.infoButton setImage:infoImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end