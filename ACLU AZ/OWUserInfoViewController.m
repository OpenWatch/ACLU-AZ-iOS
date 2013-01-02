//
//  OWUserInfoViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWUserInfoViewController.h"
#import "OWACLUAZStrings.h"
#import "JSONKit.h"
#import "OWACLUAZUtilities.h"

#define USER_INFO_FILENAME @"userinfo.json"
#define LAST_NAME_KEY @"last_name"
#define FIRST_NAME_KEY @"first_name"

@interface OWUserInfoViewController ()

@end

@implementation OWUserInfoViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:SAVE_STRING style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonPressed:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:CLEAR_STRING style:UIBarButtonItemStyleBordered target:self action:@selector(clearButtonPressed:)];
}

- (void) clearButtonPressed:(id)sender {
    [self.root bindToObject:nil];
    [self refreshValues];
}

- (void) saveButtonPressed:(id)sender {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [self.root fetchValueIntoObject:data];
    if ([self validateData:data]) {
        [self saveData:data toPath:[self userInfoPath]];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ERROR_STRING message:REQUIRED_VALUES_MSG_STRING delegate:nil cancelButtonTitle:OK_STRING otherButtonTitles: nil];
        [alert show];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadSavedDataFromPath:[self userInfoPath]];
}

- (BOOL) validateData:(NSDictionary*)data {
    NSString *firstName = [data objectForKey:FIRST_NAME_KEY];
    NSString *lastName = [data objectForKey:LAST_NAME_KEY];
    return (firstName.length > 0 && lastName.length > 0);
}

- (void) saveData:(NSDictionary*)data toPath:(NSString*)path {
    NSLog(@"obj1: %@", [data description]);
    
    NSError *error = nil;
    NSData *jsonData = [data JSONDataWithOptions:JKSerializeOptionPretty error:&error];
    if (error) {
        NSLog(@"Error serializing form data: %@%@", [error localizedDescription],[error userInfo]);
        error = nil;
    }
    if (jsonData) {
        [jsonData writeToFile:path options:NSDataWritingAtomic | NSDataWritingFileProtectionComplete error:&error];
        if (error) {
            NSLog(@"Error writing user info JSON to file %@%@", [error localizedDescription],[error userInfo]);
        }
    }
}

- (void) loadSavedDataFromPath:(NSString*)path {
    NSError *error = nil;
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if (error) {
        NSLog(@"Error reading user info JSON data: %@%@", [error localizedDescription],[error userInfo]);
        error = nil;
    }
    if (jsonData) {
        NSDictionary *data = [jsonData objectFromJSONDataWithParseOptions:JKParseOptionNone error:&error];
        if (error) {
            NSLog(@"Error parsing user info JSON: %@%@", [error localizedDescription], [error userInfo]);
        }
        if (data) {
            [self.root bindToObject:data];
            [self refreshValues];
        }
    }
}

- (void) refreshValues {
    [self.quickDialogTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSString*) userInfoPath {
    return [[OWACLUAZUtilities applicationDocumentsDirectory] stringByAppendingPathComponent:USER_INFO_FILENAME];
}

+ (QRootElement *)create {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = USER_INFO_STRING;
    root.controllerName = NSStringFromClass([self class]);
    root.grouped = YES;
	QSection *infoSection = [[QSection alloc] init];
    
    QEntryElement *firstNameElement = [[QEntryElement alloc] initWithTitle:FIRST_NAME_STRING Value:nil Placeholder:REQUIRED_STRING];
    firstNameElement.key = FIRST_NAME_KEY;
    firstNameElement.bind = [OWACLUAZUtilities textValueBindingForKey:FIRST_NAME_KEY];
    QEntryElement *lastNameElement = [[QEntryElement alloc] initWithTitle:LAST_NAME_STRING Value:nil Placeholder:REQUIRED_STRING];
    lastNameElement.key = LAST_NAME_KEY;
    lastNameElement.bind = [OWACLUAZUtilities textValueBindingForKey:LAST_NAME_KEY];
    
    [infoSection addElement:firstNameElement];
    [infoSection addElement:lastNameElement];
    
    [root addSection:infoSection];
    
    return root;
}


@end
