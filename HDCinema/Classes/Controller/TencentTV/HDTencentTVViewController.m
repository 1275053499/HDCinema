//
//  HDTencentTVViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDTencentTVViewController.h"

@interface HDTencentTVViewController ()

@end

@implementation HDTencentTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"腾讯视频";
    [self createWebViewWithHomeURL:[NSURL URLWithString:@"https://v.qq.com/"]];
    [self requestURL];
}

- (void)requestURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://v.qq.com/"]];
    [self.webView loadRequest:request];
}

@end
