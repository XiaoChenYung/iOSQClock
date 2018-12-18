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
#import <SVProgressHUD/SVProgressHUD.h>
#import <UserNotifications/UserNotifications.h>
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>

@interface ClockViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UILabel *addressTipLabel;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSDate *curDate;
/**
 位置管理器
 */
@property (nonatomic, strong) CLLocationManager *manager;

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
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [self.switchButton setHidden:true];
        self.addressTipLabel.text = @"未授权使用位置，请到设置里授权";
    }
    
    self.datePicker.minimumDate = [NSDate date];
    self.curDate = [NSDate date];
    // Do any additional setup after loading the view.
}

- (IBAction)switchChange:(UISwitch *)sender {
    if (sender.isOn) {
        _manager = [CLLocationManager new];
        _manager.delegate = self;
        [_manager requestWhenInUseAuthorization];
    } else {
        self.addressLabel.text = @"";
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [SVProgressHUD showWithStatus:@"正在获取定位..."];
        if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            // 带逆地理信息的一次定位（返回坐标和地址信息）
            self.locationManager = [[AMapLocationManager alloc] init];
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
            //   定位超时时间，最低2s，此处设置为10s
            self.locationManager.locationTimeout =2;
            //   逆地理请求超时时间，最低2s，此处设置为10s
            self.locationManager.reGeocodeTimeout = 2;
            // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
            [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
                if (error)
                {
                    NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                    if (error.code == AMapLocationErrorLocateFailed) {
                        [SVProgressHUD showErrorWithStatus:@"定位超时"];
                        return;
                    }
                }
                [SVProgressHUD dismiss];
                NSLog(@"location:%@", location);
                self.addressLabel.text = regeocode.formattedAddress;
                if (regeocode) {
                    NSLog(@"reGeocode:%@", regeocode);
                }
            }];
        }
    } else if (status == kCLAuthorizationStatusDenied) {
        [self.switchButton setHidden:true];
        self.addressTipLabel.text = @"未授权使用位置，请到设置里授权";
    }
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    self.curDate = sender.date;
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}

- (IBAction)mindMe:(UIButton *)sender {
    if ([self.curDate timeIntervalSinceNow] < 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"提醒时间不可早于当前时间" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:true completion:nil];
        return;
    }
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"clocks"];
    if (array == nil) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSDictionary *dict = @{
                               @"title": self.textField.text.length == 0 ? @"闹钟" : self.textField.text,
                               @"date": [self getDate:self.curDate],
                               @"address": self.addressLabel.text
                               };
        [mArray addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:[mArray copy] forKey:@"clocks"];
    } else {
        NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
        NSDictionary *dict = @{
                               @"title": self.textField.text.length == 0 ? @"闹钟" : self.textField.text,
                               @"date": [self getDate:self.curDate],
                               @"address": self.addressLabel.text
                               };
        [mArray addObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:[mArray copy] forKey:@"clocks"];
    }
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            if ([NSThread currentThread] != [NSThread mainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //获取用户是否同意开启通知
                    NSLog(@"request authorization successed!");
                    //第二步：新建通知内容对象
                    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
                    content.title = @"企鹅闹钟提醒";
                    content.subtitle = self.textField.text.length == 0 ? @"闹钟" : self.textField.text;
                    if (self.addressLabel.text.length > 0) {
                        content.body = self.addressLabel.text;
                    }
                    content.badge = @1;
                    
                    //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
                    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:[self.curDate timeIntervalSinceNow] repeats:NO];
                    
                    //第四步：创建UNNotificationRequest通知请求对象
                    NSString *requertIdentifier = @"RequestIdentifier";
                    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经成功添加提醒" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertVC addAction:action];
                    [self presentViewController:alertVC animated:true completion:nil];
                    //第五步：将通知加到通知中心
                    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                        NSLog(@"Error:%@",error);
                    }];
                });
            }
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}

- (IBAction)mindOther:(UIButton *)sender {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"%@ %@ %@", self.textField.text.length == 0 ? @"闹钟" : self.textField.text, [self getDate:self.curDate], self.addressLabel.text];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sms messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (NSString *)getDate:(NSDate *)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [fmt stringFromDate:date];
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
