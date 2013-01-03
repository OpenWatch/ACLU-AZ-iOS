//
//  OWReportViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
//

#import "OWReportViewController.h"
#import "OWACLUAZStrings.h"
#import "OWReport.h"
#import "QuickDialogController+Navigation.h"

@interface OWReportViewController ()

@end

@implementation OWReportViewController
@synthesize report;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) submitButtonPressed:(id)sender {
    
}

+ (QRootElement *)create {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = REPORT_STRING;
    root.controllerName = NSStringFromClass([self class]);
    root.grouped = YES;
	QSection *agencySection = [[QSection alloc] initWithTitle:AGENCY_DESCRIPTION_STRING];
    agencySection.footer = AGENCY_PLACEHOLDER_STRING;
    
    QEntryElement *agencyElement = [[QEntryElement alloc] initWithTitle:AGENCY_STRING Value:nil Placeholder:REQUIRED_STRING];
    [agencySection addElement:agencyElement];
    
    QSection *dataSection = [[QSection alloc] init];
    QDateTimeInlineElement *dateElement = [[QDateTimeInlineElement alloc] initWithTitle:INCIDENT_DATE_STRING date:[NSDate date]];
    QEntryElement *locationElement = [[QEntryElement alloc] initWithTitle:INCIDENT_LOCATION_STRING Value:nil Placeholder:REQUIRED_STRING];
    QBooleanElement *sendDeviceLocationElement = [[QBooleanElement alloc] initWithTitle:SEND_DEVICE_LOCATION_STRING BoolValue:YES];
    
    [dataSection addElement:dateElement];
    [dataSection addElement:locationElement];
    [dataSection addElement:sendDeviceLocationElement];
    
    QSection *descriptionSection = [[QSection alloc] initWithTitle:DESCRIPTION_SECTION_TITLE_STRING];
    QMultilineElement *descriptionElement = [[QMultilineElement alloc] initWithTitle:DESCRIPTION_STRING value:nil];
    [descriptionSection addElement:descriptionElement];

    
    [root addSection:agencySection];
    [root addSection:dataSection];
    [root addSection:descriptionSection];
    return root;
}

@end
