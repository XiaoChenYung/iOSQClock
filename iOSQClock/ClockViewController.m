//
//  ClockViewController.m
//  iOSQClock
//
//  Created by xiaochen yang on 2018/12/17.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import "ClockViewController.h"
#import "UIColor+Hex.h"

@interface ClockViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"闹钟";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.meButton.layer.borderColor = [UIColor mainColor].CGColor;
    self.meButton.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.meButton.layer.cornerRadius = 5;
    self.meButton.clipsToBounds = true;
    
    self.friendButton.layer.borderColor = [UIColor mainColor].CGColor;
    self.friendButton.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.friendButton.layer.cornerRadius = 5;
    self.friendButton.clipsToBounds = true;
    
    
    // Do any additional setup after loading the view.
}

- (IBAction)switchChange:(UISwitch *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
