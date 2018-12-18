//
//  ClockViewController.m
//  iOSQClock
//
//  Created by xiaochen yang on 2018/12/17.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import "ClockViewController.h"
#import "UIColor+Hex.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface ClockViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) AMapLocationManager *locationManager;

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
    if (sender.isOn) {
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        self.locationManager = [[AMapLocationManager alloc] init];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //   定位超时时间，最低2s，此处设置为10s
        self.locationManager.locationTimeout =10;
        //   逆地理请求超时时间，最低2s，此处设置为10s
        self.locationManager.reGeocodeTimeout = 10;
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            
            NSLog(@"location:%@", location);
            self.addressLabel.text = regeocode.formattedAddress;
            
            if (regeocode)
            {
                NSLog(@"reGeocode:%@", regeocode);
            }
        }];
    }
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
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
