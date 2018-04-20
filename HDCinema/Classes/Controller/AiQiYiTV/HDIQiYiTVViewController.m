//
//  HDIQiYiTVViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDIQiYiTVViewController.h"

@interface HDIQiYiTVViewController ()

@end

@implementation HDIQiYiTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"爱奇艺";
    [self createWebViewWithHomeURL:[NSURL URLWithString:@"http://www.iqiyi.com/"]];
    [self requestURL];
}

- (void)requestURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iqiyi.com/"]];
    [self.webView loadRequest:request];
}

@end
