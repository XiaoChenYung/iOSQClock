//
//  ClocksTableViewController.m
//  iOSQClock
//
//  Created by xiaochen yang on 2018/12/18.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import "ClocksTableViewController.h"

@interface ClocksTableViewController ()

@property (nonatomic, strong) NSArray *clocks;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ClocksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clocks = [[NSUserDefaults standardUserDefaults] valueForKey:@"clocks"];
    [self.tipLabel setHidden:self.clocks.count != 0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.clocks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row < self.clocks.count) {
        NSDictionary *dict = self.clocks[indexPath.row];
        cell.textLabel.text = [dict valueForKey:@"title"];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [dict valueForKey:@"date"], [dict valueForKey:@"address"]];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
