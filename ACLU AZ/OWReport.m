//
//  OWReport.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWReport.h"
#import "OWACLUAZUtilities.h"

@interface OWReport()
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end

@implementation OWReport

@dynamic locationString;
@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic agency;
@dynamic incidentDescription;
@dynamic isSubmitted;
@dynamic uuid;
@dynamic sendLocation;

- (void) loadValuesFromDictionary:(NSDictionary*)dictionary {
    self.agency = [dictionary objectForKey:AGENCY_KEY];
    self.incidentDescription = [dictionary objectForKey:INCIDENT_DESCRIPTION_KEY];
    NSObject *dateObject = [dictionary objectForKey:DATE_KEY];
    if ([dateObject isKindOfClass:[NSDate class]]) {
        self.date = (NSDate*)dateObject;
    } else if ([dateObject isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [OWACLUAZUtilities utcDateFormatter];
        self.date = [dateFormatter dateFromString:(NSString*)dateObject];
    }
    self.locationString = [dictionary objectForKey:LOCATION_KEY];
    NSNumber *latitude = [dictionary objectForKey:LATITUDE_KEY];
    if (latitude) {
        self.latitude = [latitude doubleValue];
    }
    NSNumber *longitude = [dictionary objectForKey:LONGITUDE_KEY];
    if (longitude) {
        self.longitude = [longitude doubleValue];
    }
    NSString *uuid = [dictionary objectForKey:UUID_KEY];
    if (uuid) {
        self.uuid = uuid;
    }
    NSNumber *sendLocationNumber = [dictionary objectForKey:SEND_LOCATION_KEY];
    if (sendLocationNumber) {
        self.sendLocation = [sendLocationNumber boolValue];
    } else {
        self.sendLocation = YES;
    }
}

- (NSDictionary*) dictionaryRepresentationForJSON:(BOOL)forJSON {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.agency) {
        [dictionary setObject:self.agency forKey:AGENCY_KEY];
    }
    if (self.incidentDescription) {
        [dictionary setObject:self.incidentDescription forKey:INCIDENT_DESCRIPTION_KEY];
    }
    if (self.date) {
        if (forJSON) {
            NSDateFormatter *dateFormatter = [OWACLUAZUtilities utcDateFormatter];
            [dictionary setObject:[dateFormatter stringFromDate:self.date] forKey:DATE_KEY];
        } else {
            [dictionary setObject:self.date forKey:DATE_KEY];
        }
    }
    if (self.locationString) {
        [dictionary setObject:self.locationString forKey:LOCATION_KEY];
    }
    if (self.sendLocation) {
        if (self.latitude != 0.0f) {
            [dictionary setObject:@(self.latitude) forKey:LATITUDE_KEY];
        }
        if (self.longitude != 0.0f) {
            [dictionary setObject:@(self.longitude) forKey:LONGITUDE_KEY];
        }
    }
    if (self.uuid) {
        [dictionary setObject:self.uuid forKey:UUID_KEY];
    }
    [dictionary setObject:@(self.sendLocation) forKey:SEND_LOCATION_KEY];
    return dictionary;
}

- (CLLocation*) location {
    if (self.latitude != 0.0f && self.longitude != 0.0f) {
        return [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    }
    return nil;
}

- (void) setLocation:(CLLocation *)location {
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
}

- (BOOL) validate {
    return self.locationString.length > 0 && self.incidentDescription.length > 0;
}

@end
