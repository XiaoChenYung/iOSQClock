//
//  DownViewController.m
//  iOSQClock
//
//  Created by xiaochen yang on 2018/12/17.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import "DownViewController.h"
#import "UIColor+Hex.h"

@interface DownViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"倒计时";
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
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.datePicker.locale = locale;
}
- (IBAction)switchChange:(UISwitch *)sender {
}

@end
