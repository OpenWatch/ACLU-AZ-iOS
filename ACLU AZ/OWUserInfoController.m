//
//  OWUserInfoController.m
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

#import "OWUserInfoController.h"
#import "OWACLUAZUtilities.h"
#import "JSONKit.h"

#define USER_INFO_FILENAME @"userinfo.json"

@implementation OWUserInfoController
@synthesize data;

+ (OWUserInfoController *)sharedInstance {
    static OWUserInfoController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[OWUserInfoController alloc] init];
    });
    return _sharedInstance;
}

- (id) init {
    if (self = [super init]) {
        [self loadSavedDataFromPath:[self userInfoPath]];
    }
    return self;
}

- (void) setData:(NSDictionary *)newData {
    data = newData;
    [self saveDataToPath:[self userInfoPath]];
}

- (BOOL) isValid {
    NSString *firstName = [data objectForKey:FIRST_NAME_KEY];
    NSString *lastName = [data objectForKey:LAST_NAME_KEY];
    return (firstName.length > 0 && lastName.length > 0);
}

- (void) saveDataToPath:(NSString*)path {
    NSLog(@"obj1: %@", [data description]);
    
    NSError *error = nil;
    NSData *jsonData = [data JSONDataWithOptions:JKSerializeOptionPretty error:&error];
    if (error) {
        NSLog(@"Error serializing form data: %@%@", [error localizedDescription],[error userInfo]);
        error = nil;
    }
    if (jsonData) {
        [jsonData writeToFile:path options:NSDataWritingAtomic | NSDataWritingFileProtectionComplete error:&error];
        if (error) {
            NSLog(@"Error writing user info JSON to file %@%@", [error localizedDescription],[error userInfo]);
        }
    }
}

- (void) loadSavedDataFromPath:(NSString*)path {
    NSError *error = nil;
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if (error) {
        NSLog(@"Error reading user info JSON data: %@%@", [error localizedDescription],[error userInfo]);
        error = nil;
    }
    if (jsonData) {
        NSDictionary *dataDict = [jsonData objectFromJSONDataWithParseOptions:JKParseOptionNone error:&error];
        if (error) {
            NSLog(@"Error parsing user info JSON: %@%@", [error localizedDescription], [error userInfo]);
        }
        data = dataDict;
    }
}


- (NSString*) userInfoPath {
    return [[OWACLUAZUtilities applicationDocumentsDirectory] stringByAppendingPathComponent:USER_INFO_FILENAME];
}

@end
