//
//  OWReport.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//
//  This file is part of ACLU-AZ-iOS.
//
//  ACLU-AZ-iOS is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  ACLU-AZ-iOS is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with ACLU-AZ-iOS.  If not, see <http://www.gnu.org/licenses/>.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define LOCATION_KEY @"location"
#define LATITUDE_KEY @"latitude"
#define LONGITUDE_KEY @"longitude"
#define DATE_KEY @"date"
#define AGENCY_KEY @"agency"
#define INCIDENT_DESCRIPTION_KEY @"description"
#define SEND_LOCATION_KEY @"send_location"
#define UUID_KEY @"uuid"

@interface OWReport : NSManagedObject

@property (nonatomic, retain) NSString * locationString;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString * agency;
@property (nonatomic, retain) NSString * incidentDescription;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic) BOOL isSubmitted;
@property (nonatomic) BOOL sendLocation;

- (void) loadValuesFromDictionary:(NSDictionary*)dictionary;
- (NSDictionary*) dictionaryRepresentationForJSON:(BOOL)forJSON;

- (BOOL) validate;

@end
