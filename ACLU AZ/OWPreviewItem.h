//
//  OWPreviewItem.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/3/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

@interface OWPreviewItem : NSObject <QLPreviewItem>

@property (strong) NSString *previewItemTitle;
@property (strong) NSURL *previewItemURL;

@end
