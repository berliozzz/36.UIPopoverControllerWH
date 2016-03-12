//
//  EducationViewController.h
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 12.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EducationViewControllerDelegate;

@interface EducationViewController : UITableViewController

@property (weak, nonatomic) id <EducationViewControllerDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *choisedIndexPath;
@property (strong, nonatomic) NSString *education;

@end



@protocol EducationViewControllerDelegate <NSObject>

@required

- (void)didFinishEditingEducation:(NSString*)education withIndexPath:(NSIndexPath*)indexPath;

@end
