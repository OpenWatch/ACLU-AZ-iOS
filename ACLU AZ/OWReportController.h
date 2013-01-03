//
//  OWReportController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWReportController : NSObject

- (NSArray*) allReports;

+ (OWReportController *)sharedInstance;


@end
