//
//  OWUserInfoController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LAST_NAME_KEY @"last_name"
#define FIRST_NAME_KEY @"first_name"
#define ADDRESS_1_KEY @"address_1"
#define ADDRESS_2_KEY @"address_2"
#define CITY_KEY @"city"
#define STATE_KEY @"state"
#define ZIP_KEY @"zip"
#define EMAIL_KEY @"email"
#define PHONE_KEY @"phone"
#define ALTERNATE_KEY @"alternate"

@interface OWUserInfoController : NSObject

@property (nonatomic, strong) NSDictionary *data;

+ (OWUserInfoController *)sharedInstance;

- (BOOL) isValid;

@end
