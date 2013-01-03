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

+ (void) setBindValueForElement:(QElement*)element {
    NSString *key = element.key;
    if (!key) {
        NSLog(@"Key is nil!");
        return;
    }
    NSString *binding = @"value";
    if ([element isKindOfClass:[QEntryElement class]]) {
        binding = @"textValue";
    } else if ([element isKindOfClass:[QBooleanElement class]]) {
        binding = @"boolValue";
    } else if ([element isKindOfClass:[QFloatElement class]]) {
        binding = @"floatValue";
    } else if ([element isKindOfClass:[QDateTimeInlineElement class]] || [element isKindOfClass:[QDateTimeElement class]]) {
        binding = @"dateValue";
    }
    NSString *bindValue = [NSString stringWithFormat:@"%@:%@",binding,key];
    element.bind = bindValue;
}

+ (NSString *)createUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

@end
