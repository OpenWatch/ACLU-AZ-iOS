//
//  OWReportViewController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWReport.h"

@interface OWReportViewController : QuickDialogController

@property (nonatomic, strong) OWReport *report;

+ (QRootElement *)create;

@end
