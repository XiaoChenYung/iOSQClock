//
//  TabBarViewController.m
//  iOSQClock
//
//  Created by xiaochen yang on 2018/12/17.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import "TabBarViewController.h"
#import "MeTableViewController.h"
#import "DownViewController.h"
#import "NavigationViewController.h"
#import "ClockViewController.h"
#import "UIColor+Hex.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ClockViewController *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ClockViewController"];
    UITabBarItem *it1 = [[UITabBarItem alloc] initWithTitle:@"闹钟" image:[UIImage imageNamed:@"clock"] selectedImage:[UIImage imageNamed:@"clock_sel"]];
    vc1.tabBarItem = it1;
    NavigationViewController *nav1 = [[NavigationViewController alloc] initWithRootViewController:vc1];
    
//    DownViewController *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DownViewController"];
//    UITabBarItem *it2 = [[UITabBarItem alloc] initWithTitle:@"倒计时" image:[UIImage imageNamed:@"count"] selectedImage:[UIImage imageNamed:@"count_sel"]];
//    vc2.tabBarItem = it2;
//    NavigationViewController *nav2 = [[NavigationViewController alloc] initWithRootViewController:vc2];
    
    MeTableViewController *vc3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MeTableViewController"];
    UITabBarItem *it3 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"me"] selectedImage:[UIImage imageNamed:@"me_sel"]];
    vc3.tabBarItem = it3;
    NavigationViewController *nav3 = [[NavigationViewController alloc] initWithRootViewController:vc3];
    
    [self addChildViewController:nav1];
//    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithHexString:@"#f75065"]];
    
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
