//
//  EducationViewController.m
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 12.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "EducationViewController.h"

@interface EducationViewController ()

@end

typedef enum
{
    EducationPrimary,
    EducationSecondary,
    EducationHigher
}Education;

@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionBackToTableView:)];
    self.navigationItem.rightBarButtonItem = backButton;

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.choisedIndexPath)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.choisedIndexPath];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}


#pragma mark - Actions

- (void) actionBackToTableView:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.choisedIndexPath)
    {
        [[tableView cellForRowAtIndexPath:self.choisedIndexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    if (indexPath.row == EducationPrimary)
    {
        self.education = @"Primary education";
    }
    else if (indexPath.row == EducationSecondary)
    {
        self.education = @"Secondary education";
    }
    else if (indexPath.row == EducationHigher)
    {
        self.education = @"Higher education";
    }
    
    self.choisedIndexPath = indexPath;
    [self.delegate didFinishEditingEducation:self.education withIndexPath:indexPath];
}

@end








