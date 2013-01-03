//
//  OWReport.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define LOCATION_KEY @"location"
#define LATITUDE_KEY @"latitude"
#define LONGITUDE_KEY @"longitude"
#define DATE_KEY @"date"
#define AGENCY_KEY @"agency"
#define INCIDENT_DESCRIPTION_KEY @"description"

@interface OWReport : NSManagedObject

@property (nonatomic, retain) NSString * locationString;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString * agency;
@property (nonatomic, retain) NSString * incidentDescription;
@property (nonatomic) BOOL isSubmitted;

- (void) loadValuesFromDictionary:(NSDictionary*)dictionary;
- (NSDictionary*) dictionaryRepresentation;

@end
