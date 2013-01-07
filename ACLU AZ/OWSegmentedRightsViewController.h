//
//  OWSegmentedRightsViewController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/7/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWSegmentedRightsViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *rightsViews;
@property (nonatomic, strong) UIToolbar *toolbar;

@end
