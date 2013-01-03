//
//  OWReportListViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWReportListViewController.h"
#import "OWReportController.h"
#import "OWReport.h"
#import "OWReportViewController.h"
#import "OWUtilities.h"
#import "OWACLUAZStrings.h"

@interface OWReportListViewController ()

@end

@implementation OWReportListViewController
@synthesize reports;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = REPORTS_STRING;
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

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.reports = [OWReport MR_findAll];
    [self.tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return reports.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    OWReport *report = [reports objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [OWUtilities localDateFormatter];
    cell.textLabel.text = [dateFormatter stringFromDate:report.date];
    
    if (report.isSubmitted) {
        cell.detailTextLabel.text = SUBMITTED_STRING;
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else {
        cell.detailTextLabel.text = NOT_SUBMITTED_STRING;
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QRootElement *reportRoot = [OWReportViewController create];
    OWReport *report = [reports objectAtIndex:indexPath.row];
    OWReportViewController *reportViewController = (OWReportViewController*)[QuickDialogController controllerForRoot:reportRoot];
    reportViewController.report = report;
    [self.navigationController pushViewController:reportViewController animated:YES];
}

@end
