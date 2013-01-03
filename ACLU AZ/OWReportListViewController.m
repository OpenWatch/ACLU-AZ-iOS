//
//  OWReportListViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/2/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWReportListViewController.h"
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = REPORTS_STRING;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshReports];
    [self.tableView reloadData];
}

- (void) refreshReports {
    self.reports = [NSMutableArray arrayWithArray:[OWReport MR_findAll]];
    [reports sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        OWReport *report1 = (OWReport*)obj1;
        OWReport *report2 = (OWReport*)obj2;
        return [report2.date compare:report1.date];
    }];
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
    OWReport *report = [reports objectAtIndex:indexPath.row];
    QRootElement *reportRoot = [OWReportViewController createWithReport:report];
    OWReportViewController *reportViewController = (OWReportViewController*)[QuickDialogController controllerForRoot:reportRoot];
    reportViewController.report = report;
    [self.navigationController pushViewController:reportViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //OWLocalRecording *recording = [recordingsArray objectAtIndex:indexPath.row];
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        OWReport *report = [reports objectAtIndex:indexPath.row];
        [report MR_deleteEntity];
        NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
        [context MR_saveNestedContexts];
        [reports removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
