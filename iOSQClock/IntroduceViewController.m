//
//  IntroduceViewController.m
//  iOSQClock
//
//  Created by xiaochen yang on 2018/12/18.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import "IntroduceViewController.h"
#import <WebKit/WebKit.h>

@interface IntroduceViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/XiaoChenYung/iOSQClock"]]];
    // Do any additional setup after loading the view.
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
