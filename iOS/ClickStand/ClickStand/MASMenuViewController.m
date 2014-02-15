//
//  MASMenuViewController.m
//  ClickStand
//
//  Created by Matthew Ebeweber on 2/15/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MASMenuViewController.h"



@interface MASMenuViewController ()
@property (strong, nonatomic) NSArray *menuOptions;
@end

@implementation MASMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.menuOptions = @[@[@"Home", @"Settings"],@[@"Logout"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
}

#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MASMenuTableViewCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MASMenuTableViewCell"];
    }
    
    cell.textLabel.text = self.menuOptions[indexPath.section][indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuOptions[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menuOptions count];
}

@end
