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
#import "OWACLUAZUtilities.h"

@interface OWReportViewController ()

@end

@implementation OWReportViewController
@synthesize report, locationManager, lastLocation;

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void) startLocationUpdated:(CLLocation *)location {}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:SUBMIT_STRING style:UIBarButtonItemStyleDone target:self action:@selector(submitButtonPressed:)];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!report) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    } else {
        NSDictionary *dict = [report dictionaryRepresentationForJSON:NO];
        [self.root bindToObject:dict];
        [self refreshValues];
        if (report.isSubmitted) {
            self.navigationItem.rightBarButtonItem.title = UPDATE_STRING;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) submitButtonPressed:(id)sender {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [self.root fetchValueIntoObject:data];
    NSLog(@"data: %@", [data description]);
    
    [locationManager stopUpdatingLocation];
    
    if (!report) {
        report = [OWReport MR_createEntity];
        report.uuid = [OWACLUAZUtilities createUUID];
        report.isSubmitted = NO;
    }
    [report loadValuesFromDictionary:data];
    report.location = lastLocation;
    NSLog(@"report: %@", [report description]);
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    [context MR_saveNestedContexts];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self updateCurrentLocation:newLocation];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    [self updateCurrentLocation:newLocation];
}

- (void) updateCurrentLocation:(CLLocation*)newLocation {
    if (!newLocation) {
        return;
    }
    self.lastLocation = newLocation;
}


+ (QRootElement *)createWithReport:(OWReport*)report {
    NSString *agency = nil;
    NSDate *date = nil;
    NSString *locationString = nil;
    CLLocation *location = nil;
    NSString *description = nil;
    
    if (report) {
        agency = report.agency;
        date = report.date;
        locationString = report.locationString;
        location = report.location;
        description = report.incidentDescription;
    }
    
    
    QRootElement *root = [[QRootElement alloc] init];
    root.title = REPORT_STRING;
    root.controllerName = NSStringFromClass([self class]);
    root.grouped = YES;
	QSection *agencySection = [[QSection alloc] initWithTitle:AGENCY_DESCRIPTION_STRING];
    agencySection.footer = AGENCY_PLACEHOLDER_STRING;
    
    QEntryElement *agencyElement = [[QEntryElement alloc] initWithTitle:AGENCY_STRING Value:agency Placeholder:REQUIRED_STRING];
    agencyElement.key = AGENCY_KEY;
    [OWACLUAZUtilities setBindValueForElement:agencyElement];
    [agencySection addElement:agencyElement];
    
    QSection *dataSection = [[QSection alloc] init];
    QDateTimeInlineElement *dateElement = [[QDateTimeInlineElement alloc] initWithTitle:INCIDENT_DATE_STRING date:date];
    dateElement.key = DATE_KEY;
    [OWACLUAZUtilities setBindValueForElement:dateElement];
    QEntryElement *locationElement = [[QEntryElement alloc] initWithTitle:INCIDENT_LOCATION_STRING Value:locationString Placeholder:REQUIRED_STRING];
    locationElement.key = LOCATION_KEY;
    [OWACLUAZUtilities setBindValueForElement:locationElement];
    QBooleanElement *sendDeviceLocationElement = [[QBooleanElement alloc] initWithTitle:SEND_DEVICE_LOCATION_STRING BoolValue:YES];
    sendDeviceLocationElement.key = SEND_LOCATION_KEY;
    [OWACLUAZUtilities setBindValueForElement:sendDeviceLocationElement];
    
    QMapElement *mapElement = nil;
    if (location) {
        mapElement = [[QMapElement alloc] initWithTitle:VIEW_ON_MAP_STRING coordinate:location.coordinate];
    }
    
    [dataSection addElement:dateElement];
    [dataSection addElement:locationElement];
    if (mapElement) {
        [dataSection addElement:mapElement];
    }
    [dataSection addElement:sendDeviceLocationElement];
    
    QSection *descriptionSection = [[QSection alloc] initWithTitle:DESCRIPTION_SECTION_TITLE_STRING];
    QMultilineElement *descriptionElement = [[QMultilineElement alloc] initWithTitle:DESCRIPTION_STRING value:description];
    descriptionElement.key = INCIDENT_DESCRIPTION_KEY;
    [OWACLUAZUtilities setBindValueForElement:descriptionElement];
    [descriptionSection addElement:descriptionElement];

    
    [root addSection:agencySection];
    [root addSection:dataSection];
    [root addSection:descriptionSection];
    return root;
}

- (void) refreshValues {
    [self.quickDialogTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)] withRowAnimation:UITableViewRowAnimationFade];
}


@end
