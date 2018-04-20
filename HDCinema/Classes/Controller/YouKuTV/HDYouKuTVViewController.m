//
//  HDYouKuTVViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDYouKuTVViewController.h"

@interface HDYouKuTVViewController ()

@end

@implementation HDYouKuTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"优酷视频";
    [self createWebViewWithHomeURL:[NSURL URLWithString:@"https://www.youku.com/"]];
    [self requestURL];
}

- (void)requestURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youku.com/"]];
    [self.webView loadRequest:request];
}

@end
