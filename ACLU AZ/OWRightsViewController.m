//
//  OWRightsViewController.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/3/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "OWRightsViewController.h"
#import <QuickLook/QuickLook.h>
#import "OWACLUAZStrings.h"
#import "OWPreviewItem.h"

@interface OWRightsViewController ()

@end

@implementation OWRightsViewController
@synthesize allDocuments, sections;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = KNOW_YOUR_RIGHTS_STRING;
    }
    return self;
}

- (void) loadEnglishFiles {
    NSMutableArray *englishFiles = [NSMutableArray arrayWithCapacity:3];
    OWPreviewItem *bustEnglishPreviewItem = [[OWPreviewItem alloc] init];
    bustEnglishPreviewItem.previewItemURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bust-english" ofType:@"pdf"]];
    bustEnglishPreviewItem.previewItemTitle = @"Know Your Rights Card";
    [allDocuments addObject:bustEnglishPreviewItem];
    [englishFiles addObject:bustEnglishPreviewItem];
    
    OWPreviewItem *infoEnglishPreviewItem = [[OWPreviewItem alloc] init];
    infoEnglishPreviewItem.previewItemURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"info-english" ofType:@"pdf"]];
    infoEnglishPreviewItem.previewItemTitle = @"When Encountering Police";
    [allDocuments addObject:infoEnglishPreviewItem];
    [englishFiles addObject:infoEnglishPreviewItem];
    
    OWPreviewItem *kyrEnglishPreviewItem = [[OWPreviewItem alloc] init];
    kyrEnglishPreviewItem.previewItemURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"kyr-english" ofType:@"pdf"]];
    kyrEnglishPreviewItem.previewItemTitle = @"Frequently Asked Questions";
    [allDocuments addObject:kyrEnglishPreviewItem];
    [englishFiles addObject:kyrEnglishPreviewItem];
    [sections addObject:englishFiles];

}

- (void) loadSpanishFiles {
    NSMutableArray *spanishFiles = [NSMutableArray arrayWithCapacity:3];
    
    OWPreviewItem *bustSpanishPreviewItem = [[OWPreviewItem alloc] init];
    bustSpanishPreviewItem.previewItemURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bust-spanish" ofType:@"pdf"]];
    bustSpanishPreviewItem.previewItemTitle = @"Conozca Sus Derechos";
    [allDocuments addObject:bustSpanishPreviewItem];
    [spanishFiles addObject:bustSpanishPreviewItem];
    
    OWPreviewItem *infoSpanishPreviewItem = [[OWPreviewItem alloc] init];
    infoSpanishPreviewItem.previewItemURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"info-spanish" ofType:@"pdf"]];
    infoSpanishPreviewItem.previewItemTitle = @"Derechos Frente La Policía";
    [allDocuments addObject:infoSpanishPreviewItem];
    [spanishFiles addObject:infoSpanishPreviewItem];
    
    OWPreviewItem *kyrSpanishPreviewItem = [[OWPreviewItem alloc] init];
    kyrSpanishPreviewItem.previewItemURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"kyr-spanish" ofType:@"pdf"]];
    kyrSpanishPreviewItem.previewItemTitle = @"Preguntas Más Comunes";
    [allDocuments addObject:kyrSpanishPreviewItem];
    [spanishFiles addObject:kyrSpanishPreviewItem];
    [sections addObject:spanishFiles];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allDocuments = [NSMutableArray arrayWithCapacity:6];
    self.sections = [NSMutableArray arrayWithCapacity:2];

    [self loadEnglishFiles];
    [self loadSpanishFiles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"English";
    } else if (section == 1) {
        return @"Español";
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = [sections objectAtIndex:section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSArray *sectionArray = [sections objectAtIndex:indexPath.section];
    OWPreviewItem *previewItem = [sectionArray objectAtIndex:indexPath.row];

    cell.textLabel.text = previewItem.previewItemTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    previewController.delegate = self;
    int index = indexPath.row + indexPath.section*3;
    previewController.currentPreviewItemIndex = index;
    [self presentViewController:previewController animated:YES completion:nil];
}
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
    return 6;
}

- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index {
    OWPreviewItem *previewItem = [allDocuments objectAtIndex:index];
    return previewItem;
}

@end
