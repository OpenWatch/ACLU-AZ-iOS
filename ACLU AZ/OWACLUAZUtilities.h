//
//  OWACLUAZUtilities.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

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

@end
