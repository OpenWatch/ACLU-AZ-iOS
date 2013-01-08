//
//  OWACLUAZUtilities.h
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

@interface OWACLUAZUtilities : NSObject

+ (NSString *) applicationDocumentsDirectory;
+ (void) setBindValueForElement:(QElement*)element; // key must be set
+ (NSString*) createUUID;

+ (UIColor*) lightBlueColor;
+ (UIColor*) darkBlueColor;
+ (UIColor*) backgroundPattern;

+ (NSString*) acluAPIURLString;

+ (void) setShadowForView:(UIView*)view;

+ (CGFloat) bottomOfView:(UIView*)view;
+ (CGFloat) rightOfView:(UIView*)view;
+ (NSDateFormatter*) utcDateFormatter;
+ (NSDateFormatter*) localDateFormatter;


@end
