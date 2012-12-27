//
//  OWHomeViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch. All rights reserved.
//

#import "OWHomeViewController.h"

@interface OWHomeViewController ()

@end

@implementation OWHomeViewController
@synthesize reportButton, bannerImageView, infoButton, rightsButton;

- (id)init
{
    self = [super init];
    if (self) {
        self.bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.jpg"]];
        self.reportButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.view addSubview:bannerImageView];
        [self.view addSubview:reportButton];
        [self.view addSubview:infoButton];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat bannerHeight = self.view.frame.size.height * 0.3f;
    CGFloat buttonWidth = 100.0f;
    CGFloat buttonHeight = 40.0f;
    CGFloat width = self.view.frame.size.width;
    CGFloat padding = 10.0f;
    CGFloat buttonXOrigin = width/2-buttonWidth/2;
    self.bannerImageView.frame = CGRectMake(padding, padding, width-padding*2, bannerHeight);
    self.reportButton.frame = CGRectMake(buttonXOrigin, bannerHeight+padding, buttonWidth, buttonHeight);
    self.rightsButton.frame = CGRectMake(buttonXOrigin, , <#CGFloat width#>, <#CGFloat height#>)
    self.infoButton.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
