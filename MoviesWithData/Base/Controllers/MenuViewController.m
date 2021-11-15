//
//  MenuViewController.m
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import "MenuViewController.h"
#import "MoviesViewController.h"
#import "CinemasViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark- tableView data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"סרטים";
    }
    else {
        cell.textLabel.text = @"בתי קולנוע";
    }
    
    return cell;
}

#pragma mark- table delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:true completion:nil];
    [self.dataSource didPressNumber:indexPath.row];
}

@end
