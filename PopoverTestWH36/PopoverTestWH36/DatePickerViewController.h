//
//  DatePickerViewController.h
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 11.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewControllerDelegate;

@interface DatePickerViewController : UIViewController

@property (weak, nonatomic) id <DatePickerViewControllerDelegate> delegate;
@property (strong, nonatomic) NSDate *dayOfBirth;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateOfDatePicker;

- (IBAction)setDayOfBirthPicker:(UIDatePicker *)sender;


@end


@protocol DatePickerViewControllerDelegate <NSObject>

@required

- (void)didFinishEditingDate:(NSDate *)date;

@end
