//
//  OWRightsViewController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/3/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface OWRightsViewController : UITableViewController <QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *allDocuments;
@property (nonatomic, strong) NSMutableArray *sections;

@end
