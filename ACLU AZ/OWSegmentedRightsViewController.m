//
//  OWSegmentedRightsViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/7/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWSegmentedRightsViewController.h"
#import "OWRightsView.h"
#import "OWACLUAZStrings.h"

@interface OWSegmentedRightsViewController ()

@end

@implementation OWSegmentedRightsViewController
@synthesize segmentedControl, scrollView, rightsViews, toolbar;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = KNOW_YOUR_RIGHTS_STRING;
    }
    return self;
}

- (void) setupToolbar {
    self.toolbar = [[UIToolbar alloc] initWithFrame:[self frameForToolbar]];
    [self.view addSubview:toolbar];
    [self setupSegmentedControl];
}

- (void) setupScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView.pagingEnabled = YES;
    
    for (OWRightsView *rightsView in rightsViews) {
        [scrollView addSubview:rightsView];
    }
}

- (void) setupSegmentedControl {
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:rightsViews.count];
    for (OWRightsView *rightsView in rightsViews) {
        [titles addObject:rightsView.segmentTitle];
    }
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:titles];
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.selectedSegmentIndex = 0;
    UIBarButtonItem *barControl = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.toolbar.items = @[flexibleSpace,barControl,flexibleSpace];
}

- (void) setupRightsViews {
    NSMutableArray *rights = [NSMutableArray arrayWithCapacity:5];
    OWRightsView *generalRightsView = [[OWRightsView alloc] initWithFrame:[self frameForSegment:0]];
    [generalRightsView setTitle:GENERAL_TITLE_STRING body:GENERAL_TEXTVIEW_STRING imageName:@"stickman.png" segmentTitle:GENERAL_STRING];
    [rights addObject:generalRightsView];

    OWRightsView *carRightsView = [[OWRightsView alloc] initWithFrame:[self frameForSegment:1]];
    [carRightsView setTitle:CAR_TITLE_STRING body:CAR_TEXTVIEW_STRING imageName:@"driving.png" segmentTitle:CAR_STRING];
    [rights addObject:carRightsView];
    
    OWRightsView *streetRightsView = [[OWRightsView alloc] initWithFrame:[self frameForSegment:2]];
    [streetRightsView setTitle:STREET_TITLE_STRING body:STREET_TEXTVIEW_STRING imageName:@"street.png" segmentTitle:STREET_STRING];
    [rights addObject:streetRightsView];
    
    OWRightsView *homeRightsView = [[OWRightsView alloc] initWithFrame:[self frameForSegment:3]];
    [homeRightsView setTitle:HOME_TITLE_STRING body:HOME_TEXTVIEW_STRING imageName:@"home.png" segmentTitle:HOME_STRING];
    [rights addObject:homeRightsView];
    
    OWRightsView *jailRightsView = [[OWRightsView alloc] initWithFrame:[self frameForSegment:4]];
    [jailRightsView setTitle:JAIL_TITLE_STRING body:JAIL_TEXTVIEW_STRING imageName:@"jail.png" segmentTitle:JAIL_STRING];
    [rights addObject:jailRightsView];
    
    self.rightsViews = rights;
}

-(CGRect) frameForSegment:(int)segmentIndex {
    return CGRectMake(self.view.frame.size.width * segmentIndex, 0, self.view.frame.size.width, self.view.frame.size.height - self.toolbar.frame.size.height - 45.0f);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"satinweave.png"]];
}

- (CGRect) frameForToolbar {
    CGFloat toolbarHeight = 45.0f;
    return CGRectMake(0, self.view.frame.size.height-toolbarHeight, self.view.frame.size.width, toolbarHeight);
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupRightsViews];
    [self setupToolbar];
    [self setupScrollView];
    self.toolbar.frame = [self frameForToolbar];
    CGFloat scrollViewHeight = self.view.frame.size.height-self.toolbar.frame.size.height;
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, scrollViewHeight);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * rightsViews.count, scrollViewHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) segmentedControlValueChanged:(id)sender {
    CGRect frame = [self frameForSegment:segmentedControl.selectedSegmentIndex];
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.segmentedControl.selectedSegmentIndex = page;
}


@end
