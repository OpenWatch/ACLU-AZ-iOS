//
//  OWUserInfoController.h
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
