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
#import "OWUtilities.h"

@interface OWAboutViewController ()

@end

@implementation OWAboutViewController
@synthesize acluImageView, openwatchImageView, aboutTextView;

- (id)init
{
    self = [super init];
    if (self) {

        self.title = ABOUT_STRING;
        self.aboutTextView = [[UITextView alloc] init];
        [self.view addSubview:aboutTextView];
        self.view.backgroundColor = [OWACLUAZUtilities backgroundPattern];
        [self setupBanners];
    }
    return self;
}

- (void) setupBanners {
    self.acluImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aclu-logo.jpg"]];
    self.openwatchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"openwatch.png"]];
    [self.view addSubview:acluImageView];
    [self.view addSubview:openwatchImageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.aboutTextView.text = ABOUT_MESSAGE_STRING;
    self.aboutTextView.editable = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.acluImageView.frame = CGRectMake(0, 0, acluImageView.image.size.width, acluImageView.image.size.height);
    self.openwatchImageView.frame = CGRectMake(0, [OWUtilities bottomOfView:acluImageView], openwatchImageView.image.size.width, openwatchImageView.image.size.height);
    self.aboutTextView.frame = CGRectMake(0, [OWUtilities bottomOfView:openwatchImageView], self.view.frame.size.width, self.view.frame.size.height-[OWUtilities bottomOfView:openwatchImageView]);
}

@end
