//
//  HDCustomBrowseViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDCustomBrowseViewController.h"

@interface HDCustomBrowseViewController ()

@end

@implementation HDCustomBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createWebViewWithHomeURL:self.URL];
    [self requestURL];
}

- (void)requestURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [super webView:webView didFinishNavigation:navigation];
    
    weakSelf(weakSelf);
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        weakSelf.navigationItem.title = title;
    }];
}

@end
