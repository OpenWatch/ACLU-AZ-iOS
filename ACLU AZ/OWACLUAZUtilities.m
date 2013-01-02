//
//  OWACLUAZUtilities.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWACLUAZUtilities.h"

@implementation OWACLUAZUtilities

+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (NSString*) textValueBindingForKey:(NSString*)key {
    return [NSString stringWithFormat:@"textValue:%@", key];
}

@end
