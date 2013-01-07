//
//  OWACLUAZUtilities.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWACLUAZUtilities.h"
#import "QuartzCore/CALayer.h"

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

+ (UIColor*) lightBlueColor {
    UIColor *lightBlueColor = [UIColor colorWithRed:0.16078431372549 green:0.20392156862745 blue:0.27450980392157 alpha:1.0f];
    return lightBlueColor;
}
+ (UIColor*) darkBlueColor {
    UIColor *darkBlueColor = [UIColor colorWithRed:0.11764705882353 green:0.16078431372549 blue:0.24705882352941 alpha:1.0f];
    return darkBlueColor;
}
+ (UIColor*) backgroundPattern {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_bg.png"]];
}

+ (NSString*) acluAPIURLString {
    return @"https://az.openwatch.net/";
}

+ (void) setShadowForView:(UIView*)view {
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 3.0;
    view.clipsToBounds = NO;
}

+ (CGFloat) bottomOfView:(UIView *)view {
    return view.frame.origin.y + view.frame.size.height;
}

+ (CGFloat) rightOfView:(UIView *)view {
    return view.frame.origin.x + view.frame.size.width;
}

+ (NSDateFormatter*) utcDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd' 'HH:mm:ss";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return dateFormatter;
}


+ (NSDateFormatter*) localDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd' 'h:mm a";
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.locale = [NSLocale currentLocale];
    return dateFormatter;
}

@end
