//
//  DatePickerViewController.m
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 11.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController () 

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionBackToTableView:)];
    self.navigationItem.rightBarButtonItem = backButton;
    
    if (self.dayOfBirth)
    {
        self.dateOfDatePicker.date = self.dayOfBirth;
    }
}


#pragma mark - Actions

- (void) actionBackToTableView:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) dealloc
{
    NSLog(@"DatePickerViewController has been deallocated");
}

- (IBAction)setDayOfBirthPicker:(UIDatePicker *)sender
{
    [self.delegate didFinishEditingDate:sender.date];
    self.dayOfBirth = sender.date;
}

@end











