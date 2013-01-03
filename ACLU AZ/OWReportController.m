//
//  OWReportController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWReportController.h"
#import "OWReport.h"

@implementation OWReportController

+ (OWReportController *)sharedInstance {
    static OWReportController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[OWReportController alloc] init];
    });
    return _sharedInstance;
}

- (NSArray*) allReports {
    NSArray *reports = [OWReport MR_findAll];
    return reports;
}

@end
