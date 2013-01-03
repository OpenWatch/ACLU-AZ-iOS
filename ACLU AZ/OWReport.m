//
//  OWReport.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWReport.h"
#import "OWReportController.h"


@implementation OWReport

@dynamic locationString;
@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic agency;
@dynamic incidentDescription;
@dynamic isSubmitted;

- (void) loadValuesFromDictionary:(NSDictionary*)dictionary {
    self.agency = [dictionary objectForKey:AGENCY_KEY];
    self.incidentDescription = [dictionary objectForKey:INCIDENT_DESCRIPTION_KEY];
    self.date = [dictionary objectForKey:DATE_KEY];
    self.locationString = [dictionary objectForKey:LOCATION_KEY];
}
- (NSDictionary*) dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.agency) {
        [dictionary setObject:self.agency forKey:AGENCY_KEY];
    }
    if (self.incidentDescription) {
        [dictionary setObject:self.incidentDescription forKey:INCIDENT_DESCRIPTION_KEY];
    }
    if (self.date) {
        [dictionary setObject:self.date forKey:DATE_KEY];
    }
    if (self.locationString) {
        [dictionary setObject:self.locationString forKey:LOCATION_KEY];
    }
    if (self.latitude != 0.0f) {
        [dictionary setObject:@(self.latitude) forKey:LATITUDE_KEY];
    }
    if (self.longitude != 0.0f) {
        [dictionary setObject:@(self.longitude) forKey:LONGITUDE_KEY];
    }
    return dictionary;
}

@end
