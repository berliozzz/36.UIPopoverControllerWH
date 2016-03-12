//
//  AccountViewController.m
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 11.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "AccountViewController.h"
#import "DetailsViewController.h"
#import "DatePickerViewController.h"
#import "EducationViewController.h"


@interface AccountViewController () <UIPopoverPresentationControllerDelegate, UITextFieldDelegate,
                                    DatePickerViewControllerDelegate, EducationViewControllerDelegate>

@end

static NSString *kFirstName             = @"firstName";
static NSString *kLastName              = @"lastName";
static NSString *kGender                = @"gender";
static NSString *kdateOfBirthday        = @"dateOfBirthday";
static NSString *kdateOfBirthdayText    = @"dateOfBirthdayText";
static NSString *kEducation             = @"education";
static NSString *kEducationIndexPathRow = @"educationIndexPathRow";
static NSString *kEducationIndexPathSection = @"educationIndexPathSection";

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithTitle:@"info"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionInfo:)];
    self.navigationItem.rightBarButtonItem = infoButton;
    
    [self loadSettings];
}

#pragma mark - Save and Load

- (void) saveSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.firstNameField.text forKey:kFirstName];
    [userDefaults setObject:self.lastNameField.text forKey:kLastName];
    [userDefaults setObject:self.educationField.text forKey:kEducation];
    [userDefaults setObject:self.dayOfBirthField.text forKey:kdateOfBirthdayText];
    [userDefaults setObject:self.dateOfBirthday forKey:kdateOfBirthday];
    [userDefaults setInteger:self.educationIndexPath.section forKey:kEducationIndexPathSection];
    [userDefaults setInteger:self.educationIndexPath.row forKey:kEducationIndexPathRow];
    
    [userDefaults synchronize];
}

- (void) loadSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.firstNameField.text = [userDefaults objectForKey:kFirstName];
    self.lastNameField.text = [userDefaults objectForKey:kLastName];
    self.educationField.text = [userDefaults objectForKey:kEducation];
    self.dayOfBirthField.text = [userDefaults objectForKey:kdateOfBirthdayText];
    self.dateOfBirthday = [userDefaults objectForKey:kdateOfBirthday];
    NSInteger section = [userDefaults integerForKey:kEducationIndexPathSection];
    NSInteger row = [userDefaults integerForKey:kEducationIndexPathRow];
    self.educationIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
}

#pragma mark - Actions

- (void) actionInfo:(UIBarButtonItem*)sender
{
    DetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    [self showInfoPopoverController:controller inPopoverFromSender:sender];
}

#pragma mark - Private Methods

- (void) showInfoPopoverController:(UIViewController*)vc inPopoverFromSender:(id)sender
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [navController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popController.barButtonItem = sender;
    }
}

- (void) showDatePickerPopoverController:(UIViewController*)vc
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [navController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    popController.delegate = self;
    
    popController.sourceView = self.dayOfBirthField;
    popController.sourceRect = CGRectMake(30, 50, 10, 10);
}
- (void) showEducationPopoverController:(UIViewController*)vc
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [navController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    popController.delegate = self;
    
    popController.sourceView = self.educationField;
    popController.sourceRect = CGRectMake(30, 50, 10, 10);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.dayOfBirthField])
    {
        DatePickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerViewController"];
        controller.dayOfBirth = self.dateOfBirthday;
        controller.delegate = self;
        [self showDatePickerPopoverController:controller];
        
        return NO;
    }
    else if ([textField isEqual:self.educationField])
    {
        EducationViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EducationViewController"];
        controller.choisedIndexPath = self.educationIndexPath;
        controller.delegate = self;
        [self showEducationPopoverController:controller];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self saveSettings];
    
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

#pragma mark - DatePickerViewControllerDelegate

- (void)didFinishEditingDate:(NSDate *)date
{
    self.dateOfBirthday = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    self.dayOfBirthField.text = [dateFormatter stringFromDate:date];
    
    [self.tableView reloadData];
}

#pragma mark - EducationViewControllerDelegate

- (void)didFinishEditingEducation:(NSString*)education withIndexPath:(NSIndexPath *)indexPath
{
    self.educationField.text = education;
    self.educationIndexPath = indexPath;
    
    [self.tableView reloadData];
}







@end
























