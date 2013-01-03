//
//  OWReportViewController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWReport.h"
#import <CoreLocation/CoreLocation.h>

@interface OWReportViewController : QuickDialogController < CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, strong) OWReport *report;
@property (nonatomic, strong) UIBarButtonItem *submitButton;

+ (QRootElement *)create;

@end
