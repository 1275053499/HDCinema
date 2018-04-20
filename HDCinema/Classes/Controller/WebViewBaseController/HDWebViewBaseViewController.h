//
//  HDWebViewBaseViewController.h
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDBaseViewController.h"
#import <WebKit/WebKit.h>

@interface HDWebViewBaseViewController : HDBaseViewController

@property (nonatomic, weak) WKWebView *webView;

/**
 创建WebView或者自行创建
 */
- (void)createWebViewWithHomeURL:(NSURL *)homeURL;

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;

@end
