//
//  DetailsViewController.m
//  PopoverTestWH36
//
//  Created by Nikolay Berlioz on 11.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                  style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionBackToTableView:)];
    self.navigationItem.rightBarButtonItem = backButton;
}

#pragma mark - Actions

- (void) actionBackToTableView:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) dealloc
{
    NSLog(@"DetailsViewController has been deallocated");
}



@end
