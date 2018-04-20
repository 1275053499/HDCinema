//
//  HDMangoTVViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDMangoTVViewController.h"

@interface HDMangoTVViewController ()

@end

@implementation HDMangoTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"芒果TV";
    [self createWebViewWithHomeURL:[NSURL URLWithString:@"https://www.mgtv.com/"]];
    [self requestURL];
}

- (void)requestURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.mgtv.com/"]];
    [self.webView loadRequest:request];
}

@end
