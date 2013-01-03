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
#import "OWUserInfoViewController.h"
#import "OWUserInfoController.h"
#import "OWReportViewController.h"
#import "OWReportListViewController.h"
#import "QuartzCore/CALayer.h"

@interface OWACLUAZHomeViewController ()

@end

@implementation OWACLUAZHomeViewController
@synthesize reportButton, bannerImageView, settingsButton, rightsButton;

- (id)init
{
    self = [super init];
    if (self) {
        self.bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.jpg"]];
        self.bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
        bannerImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        bannerImageView.layer.shadowOffset = CGSizeMake(0, 1);
        bannerImageView.layer.shadowOpacity = 1;
        bannerImageView.layer.shadowRadius = 3.0;
        bannerImageView.clipsToBounds = NO;
        self.reportButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"14-gear.png"] style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonPressed:)];
        self.rightsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.view addSubview:bannerImageView];
        [self.view addSubview:reportButton];
        [self.view addSubview:rightsButton];
        
        [self.reportButton addTarget:self action:@selector(reportButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = settingsButton;
        self.title = STOP_SB1070_STRING;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_bg.png"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor lightGrayColor];

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
    self.bannerImageView.frame = CGRectMake(padding, padding*2+45, width-padding*2, bannerHeight);
    self.reportButton.frame = CGRectMake(buttonXOrigin, [OWUtilities bottomOfView:bannerImageView]+padding*2, buttonWidth, buttonHeight);
    self.rightsButton.frame = CGRectMake(buttonXOrigin, [OWUtilities bottomOfView:reportButton]+padding*2, buttonWidth, buttonHeight);
    [self.reportButton setTitle:REPORT_STRING forState:UIControlStateNormal];
    [self.rightsButton setTitle:KNOW_YOUR_RIGHTS_STRING forState:UIControlStateNormal];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reportButtonPressed:(id)sender {
    OWUserInfoController *infoController = [OWUserInfoController sharedInstance];
    if ([infoController isValid]) {
        QRootElement *reportRoot = [OWReportViewController createWithReport:nil];
        OWReportViewController *reportViewController = (OWReportViewController*)[QuickDialogController controllerForRoot:reportRoot];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:reportViewController];
        [self presentViewController:navController animated:YES completion:nil];
    } else {
        QRootElement *userInfoRoot = [OWUserInfoViewController create];
        OWUserInfoViewController *userInfoController = (OWUserInfoViewController*)[QuickDialogController controllerForRoot:userInfoRoot];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:userInfoController];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

- (void) infoButtonPressed:(id)sender {
    OWReportListViewController *reportList = [[OWReportListViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:reportList animated:YES];
}

@end
