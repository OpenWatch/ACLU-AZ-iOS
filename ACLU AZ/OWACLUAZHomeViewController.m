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
@synthesize reportButton, bannerImageView, settingsButton, rightsButton, buttonView;

- (id)init
{
    self = [super init];
    if (self) {
        [self setupBannerImage];
        [self setupButtons];

        self.settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"14-gear.png"] style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonPressed:)];
        self.navigationItem.rightBarButtonItem = settingsButton;

        
        self.title = STOP_SB1070_STRING;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_bg.png"]];

    }
    return self;
}

- (void) setupBannerImage {
    self.bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.jpg"]];
    self.bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self setShadowForView:bannerImageView];
    [self.view addSubview:bannerImageView];

}

- (void) setShadowForView:(UIView*)view {
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 3.0;
    view.clipsToBounds = NO;
}

- (void) setupButtons {
    CGFloat buttonWidth = 200.0f;
    CGFloat buttonHeight = 60.0f;
    CGFloat padding = 10.0f;

    [self.reportButton setTitle:REPORT_STRING forState:UIControlStateNormal];
    [self.rightsButton setTitle:KNOW_YOUR_RIGHTS_STRING forState:UIControlStateNormal];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight*2 + padding*2)];
    self.reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reportButton addTarget:self action:@selector(reportButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.reportButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.rightsButton.frame = CGRectMake(0, [OWUtilities bottomOfView:reportButton]+padding*2, buttonWidth, buttonHeight);
    
    [self setShadowForView:reportButton];
    [self setShadowForView:rightsButton];

    [self.buttonView addSubview:reportButton];
    [self.buttonView addSubview:rightsButton];
    [self.view addSubview:buttonView];

    UIImage *greenButtonImage = [[UIImage imageNamed:@"greenButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *greenButtonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    UIImage *blueButtonImage = [[UIImage imageNamed:@"blueButton.png"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *blueButtonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"]
                                          resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [reportButton setBackgroundImage:greenButtonImage forState:UIControlStateNormal]
    ;
    [reportButton setBackgroundImage:greenButtonImageHighlight forState:UIControlStateHighlighted];
    
    [rightsButton setBackgroundImage:blueButtonImage forState:UIControlStateNormal]
    ;
    [rightsButton setBackgroundImage:blueButtonImageHighlight forState:UIControlStateHighlighted];
    
    [self.reportButton setTitle:REPORT_STRING forState:UIControlStateNormal];
    [self.rightsButton setTitle:KNOW_YOUR_RIGHTS_STRING forState:UIControlStateNormal];
    
    [self styleTextForButton:reportButton];
    [self styleTextForButton:rightsButton];
}

- (void) styleTextForButton:(UIButton*)button {
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor lightGrayColor];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat bannerHeight = 138.0f;

    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat padding = 10.0f;

    self.bannerImageView.frame = CGRectMake(padding, padding*2+45, width-padding*2, bannerHeight);
    CGFloat buttonViewXOrigin = floorf(width/2-buttonView.frame.size.width/2);
    CGFloat buttonViewYOrigin = floorf([OWUtilities bottomOfView:bannerImageView] + ((height - [OWUtilities bottomOfView:bannerImageView]) / 2) - (buttonView.frame.size.height/2));
    self.buttonView.frame = CGRectMake(buttonViewXOrigin, buttonViewYOrigin, buttonView.frame.size.width, buttonView.frame.size.height);
    
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
