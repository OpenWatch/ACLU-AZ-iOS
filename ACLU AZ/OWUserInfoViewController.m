//
//  OWUserInfoViewController.m
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

#import "OWUserInfoViewController.h"
#import "OWACLUAZStrings.h"
#import "JSONKit.h"
#import "OWACLUAZUtilities.h"
#import "OWUserInfoController.h"
#import "OWReportViewController.h"


@interface OWUserInfoViewController ()

@end

@implementation OWUserInfoViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NEXT_STRING style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonPressed:)];
}

- (void) clearButtonPressed:(id)sender {
    [self.root bindToObject:nil];
    [self refreshValues];
}

- (void) nextButtonPressed:(id)sender {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [self.root fetchValueIntoObject:data];
    
    OWUserInfoController *userInfoController = [OWUserInfoController sharedInstance];
    userInfoController.data = data;
    
    if ([userInfoController isValid]) {
        QRootElement *reportRoot = [OWReportViewController createWithReport:nil];
        OWReportViewController *reportViewController = (OWReportViewController*)[QuickDialogController controllerForRoot:reportRoot];
        [self.navigationController pushViewController:reportViewController animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ERROR_STRING message:REQUIRED_VALUES_MSG_STRING delegate:nil cancelButtonTitle:OK_STRING otherButtonTitles: nil];
        [alert show];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    OWUserInfoController *userInfoController = [OWUserInfoController sharedInstance];
    if (userInfoController.data) {
        [self.root bindToObject:userInfoController.data];
        [self refreshValues];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NOTE_STRING message:DISCLAIMER_STRING delegate:nil cancelButtonTitle:OK_STRING otherButtonTitles:nil];
    [alert show];
}

- (void) refreshValues {
    [self.quickDialogTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)] withRowAnimation:UITableViewRowAnimationFade];
}


+ (QRootElement *)create {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = USER_INFO_STRING;
    root.controllerName = NSStringFromClass([self class]);
    root.grouped = YES;
	QSection *nameSection = [[QSection alloc] initWithTitle:NAME_STRING];
    QSection *addressSection = [[QSection alloc] initWithTitle:ADDRESS_STRING];
    QSection *otherSection = [[QSection alloc] initWithTitle:OTHER_STRING];
    
    QEntryElement *firstNameElement = [[QEntryElement alloc] initWithTitle:FIRST_NAME_STRING Value:nil Placeholder:REQUIRED_STRING];
    firstNameElement.key = FIRST_NAME_KEY;
    [OWACLUAZUtilities setBindValueForElement:firstNameElement];
    QEntryElement *lastNameElement = [[QEntryElement alloc] initWithTitle:LAST_NAME_STRING Value:nil Placeholder:REQUIRED_STRING];
    lastNameElement.key = LAST_NAME_KEY;
    [OWACLUAZUtilities setBindValueForElement:lastNameElement];
    [nameSection addElement:firstNameElement];
    [nameSection addElement:lastNameElement];
    
    QEntryElement *address1Element = [[QEntryElement alloc] initWithTitle:[ADDRESS_STRING stringByAppendingString:@" 1"] Value:nil];
    address1Element.key = ADDRESS_1_KEY;
    [OWACLUAZUtilities setBindValueForElement:address1Element];
    QEntryElement *address2Element = [[QEntryElement alloc] initWithTitle:[ADDRESS_STRING stringByAppendingString:@" 2"] Value:nil];
    address2Element.key = ADDRESS_2_KEY;
    [OWACLUAZUtilities setBindValueForElement:address2Element];
    QEntryElement *cityElement = [[QEntryElement alloc] initWithTitle:CITY_STRING Value:nil];
    cityElement.key = CITY_KEY;
    [OWACLUAZUtilities setBindValueForElement:cityElement];
    QEntryElement *stateElement = [[QEntryElement alloc] initWithTitle:STATE_STRING Value:nil];
    stateElement.key = STATE_KEY;
    [OWACLUAZUtilities setBindValueForElement:stateElement];
    QEntryElement *zipElement = [[QEntryElement alloc] initWithTitle:ZIP_CODE_STRING Value:nil Placeholder:REQUIRED_STRING];
    zipElement.key = ZIP_KEY;
    [OWACLUAZUtilities setBindValueForElement:zipElement];
    zipElement.keyboardType = UIKeyboardTypeNumberPad;
    
    [addressSection addElement:address1Element];
    [addressSection addElement:address2Element];
    [addressSection addElement:cityElement];
    [addressSection addElement:stateElement];
    [addressSection addElement:zipElement];
    
    QEntryElement *emailElement = [[QEntryElement alloc] initWithTitle:EMAIL_STRING Value:nil];
    emailElement.key = EMAIL_KEY;
    [OWACLUAZUtilities setBindValueForElement:emailElement];
    emailElement.keyboardType = UIKeyboardTypeEmailAddress;
    QEntryElement *phoneElement = [[QEntryElement alloc] initWithTitle:PHONE_STRING Value:nil];
    phoneElement.key = PHONE_KEY;
    [OWACLUAZUtilities setBindValueForElement:phoneElement];
    phoneElement.keyboardType = UIKeyboardTypeNumberPad;
    QEntryElement *alternateElement = [[QEntryElement alloc] initWithTitle:ALTERNATE_STRING Value:nil];
    alternateElement.key = ALTERNATE_KEY;
    [OWACLUAZUtilities setBindValueForElement:alternateElement];
    [otherSection addElement:emailElement];
    [otherSection addElement:phoneElement];
    [otherSection addElement:alternateElement];
    
    [root addSection:nameSection];
    [root addSection:addressSection];
    [root addSection:otherSection];
    
    return root;
}


@end
