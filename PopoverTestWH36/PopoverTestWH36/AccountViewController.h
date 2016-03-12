//
//  AccountViewController.h
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 11.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *dayOfBirthField;
@property (weak, nonatomic) IBOutlet UITextField *educationField;


@property (strong, nonatomic) NSIndexPath *educationIndexPath;
@property (strong, nonatomic) NSDate *dateOfBirthday;


@end


