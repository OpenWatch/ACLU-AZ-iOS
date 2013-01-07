//
//  OWHomeViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import "OWACLUAZHomeViewController.h"
#import "OWACLUAZStrings.h"
#import "OWUserInfoViewController.h"
#import "OWUserInfoController.h"
#import "OWReportViewController.h"
#import "OWReportListViewController.h"
#import "OWACLUAZUtilities.h"
#import "OWRightsViewController.h"
#import "OWAboutViewController.h"
#import "OWSegmentedRightsViewController.h"

@interface OWACLUAZHomeViewController ()

@end

@implementation OWACLUAZHomeViewController
@synthesize reportButton, bannerImageView, settingsButton, rightsButton, buttonView, aboutButton;

- (id)init
{
    self = [super init];
    if (self) {
        [self setupBannerImage];
        [self setupButtons];

        self.settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list.png"] style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonPressed:)];
        self.navigationItem.rightBarButtonItem = settingsButton;
        
        self.aboutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"about_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(aboutButtonPressed:)];
        self.navigationItem.leftBarButtonItem = aboutButton;
        
        self.title = STOP_SB1070_STRING;
        self.view.backgroundColor = [OWACLUAZUtilities backgroundPattern];
    }
    return self;
}

- (void) setupBannerImage {
    self.bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aclu-logo.jpg"]];
    self.bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [OWACLUAZUtilities setShadowForView:bannerImageView];
    [self.view addSubview:bannerImageView];

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
    [self.rightsButton addTarget:self action:@selector(rightsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.reportButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.rightsButton.frame = CGRectMake(0, [OWACLUAZUtilities bottomOfView:reportButton]+padding*2, buttonWidth, buttonHeight);
    
    [OWACLUAZUtilities setShadowForView:reportButton];
    [OWACLUAZUtilities setShadowForView:rightsButton];

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
    
    self.rightsButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
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

    self.bannerImageView.frame = CGRectMake(padding, padding*2, width-padding*2, bannerHeight);
    CGFloat buttonViewXOrigin = floorf(width/2-buttonView.frame.size.width/2);
    CGFloat buttonViewYOrigin = floorf([OWACLUAZUtilities bottomOfView:bannerImageView] + ((height - [OWACLUAZUtilities bottomOfView:bannerImageView]) / 2) - (buttonView.frame.size.height/2));
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
    QRootElement *userInfoRoot = [OWUserInfoViewController create];
    UIViewController *viewController = [QuickDialogController controllerForRoot:userInfoRoot];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void) rightsButtonPressed:(id)sender {
    /*OWRightsViewController *rightsVC = [[OWRightsViewController alloc] initWithStyle:UITableViewStyleGrouped];*/
    OWSegmentedRightsViewController *rightsVC = [[OWSegmentedRightsViewController alloc] init];
    [self.navigationController pushViewController:rightsVC animated:YES];
}

- (void) infoButtonPressed:(id)sender {
    OWReportListViewController *reportList = [[OWReportListViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:reportList animated:YES];
}

- (void) aboutButtonPressed:(id)sender {
    OWAboutViewController *aboutViewVC = [[OWAboutViewController alloc] init];
    [self.navigationController pushViewController:aboutViewVC animated:YES];
}

@end
