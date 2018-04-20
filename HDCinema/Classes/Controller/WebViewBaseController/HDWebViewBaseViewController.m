//
//  HDWebViewBaseViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDWebViewBaseViewController.h"
#import "HDTraceViewController.h"

@interface HDWebViewBaseViewController ()
<
WKNavigationDelegate,
WKUIDelegate,
HDTraceViewControllerDelegate
>

/** 主页 */
@property (nonatomic, strong) NSURL *homeURL;

@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *forwardItem;
@property (nonatomic, strong) UIBarButtonItem *homeItem;
@property (nonatomic, strong) UIBarButtonItem *traceItem;

@property (nonatomic, weak) UIProgressView *progressView;

@end

@implementation HDWebViewBaseViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createWebViewWithHomeURL:(NSURL *)homeURL {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:webView];
    [self.view insertSubview:webView belowSubview:self.progressView];
    self.webView = webView;
    
    if (HDiOS11) {
        if (@available(iOS 11.0, *)) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    if (!HDStringIsEmpty(homeURL.absoluteString) &&
        ![homeURL.absoluteString isEqualToString:@"http://"]) {
        self.homeURL = homeURL;
        CGFloat width = 37;
        UIButton *traceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [traceBtn setTitle:@"线路" forState:UIControlStateNormal];
        [traceBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [traceBtn setTitleColor:HDColorFromHex(0x999999) forState:UIControlStateNormal];
        [traceBtn setTitleColor:HDColorFromHex(0xbbbbbb) forState:UIControlStateHighlighted];
        [traceBtn addTarget:self action:@selector(clickTraceBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *traceItem = [[UIBarButtonItem alloc] initWithCustomView:traceBtn];
        
        UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [homeBtn setImage:[UIImage imageNamed:@"nav_r_n"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"nav_r_h"] forState:UIControlStateHighlighted];
        [homeBtn addTarget:self action:@selector(clickHomeBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
        [self.navigationItem setRightBarButtonItems:@[homeItem, traceItem]];
        self.homeItem = homeItem;
        self.traceItem = traceItem;
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [backBtn setTitle:@"后退" forState:UIControlStateNormal];
        [backBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [backBtn setTitleColor:HDColorFromHex(0x999999) forState:UIControlStateNormal];
        [backBtn setTitleColor:HDColorFromHex(0xbbbbbb) forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *forwardBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [forwardBtn setTitle:@"前进" forState:UIControlStateNormal];
        [forwardBtn setTitleColor:HDColorFromHex(0x999999) forState:UIControlStateNormal];
        [forwardBtn setTitleColor:HDColorFromHex(0xbbbbbb) forState:UIControlStateHighlighted];
        [forwardBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [forwardBtn addTarget:self action:@selector(clickForwardBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc] initWithCustomView:forwardBtn];
        self.backItem = backItem;
        self.forwardItem = forwardItem;
    }
}

- (UIProgressView *)progressView {
    if(!_progressView) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        progressView.tintColor = HDColorFromHex(0x0093ff);
        progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:progressView];
        _progressView = progressView;
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(@2);
        }];
    }
    
    return _progressView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - HDTraceViewControllerDelegate
- (void)traceClick:(NSString *)URLString {
    if (HDStringIsEmpty(URLString)) return;
    
    weakSelf(weakSelf);
    [self.webView evaluateJavaScript:@"document.location.href" completionHandler:^(NSString * _Nullable URL, NSError * _Nullable error) {
        NSString *originURL = [URL componentsSeparatedByString:@"url="].lastObject;
        
        if ([URL hasPrefix:@"http"]) {
            NSString *traceURL = [NSString stringWithFormat:@"%@%@", URLString, originURL];
            HDLog(@"traceURL = %@", traceURL);
            [UIPasteboard generalPasteboard].string = traceURL;
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:traceURL]];
            [weakSelf.webView loadRequest:request];
        }
    }];
}


#pragma mark - WKWebView
// 计算进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

- (void)clickTraceBtn {
    HDTraceViewController *trace = [[HDTraceViewController alloc] init];
    trace.delegate = self;
    [self.navigationController pushViewController:trace animated:YES];
}

- (void)clickHomeBtn {
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.homeURL]];
    [self updateRightBarButtonItem];
}

- (void)clickBackBtn {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    
    [self updateRightBarButtonItem];
}

- (void)clickForwardBtn {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
    
    [self updateRightBarButtonItem];
}

- (void)updateRightBarButtonItem {
    NSMutableArray *arr = [NSMutableArray array];
    if (self.homeItem) {
        [arr addObject:self.homeItem];
    }
    
    if (self.traceItem) {
        [arr addObject:self.traceItem];
    }
    
    if ([self.webView canGoBack] && self.backItem) {
        [arr addObject:self.backItem];
    }
    
    if ([self.webView canGoForward] && self.forwardItem) {
        [arr addObject:self.forwardItem];
    }
    
    [self.navigationItem setRightBarButtonItems:arr];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self updateRightBarButtonItem];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    HDLog(@"页面加载失败 == %@", navigation);
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    HDLog(@"响应后 responseURL == %@", navigationResponse.response.URL.absoluteString);
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    // 不允许跳转
    // decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *requestURL = navigationAction.request.URL.absoluteString;
    HDLog(@"发送请求 requestURL == %@", requestURL);
    // 如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    // 不允许跳转
    // decisionHandler(WKNavigationActionPolicyCancel);
}


#pragma mark - WKUIDelegate
//// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    return [[WKWebView alloc] init];
//}
//
//// 输入框
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
//    completionHandler(@"http");
//}
//
//// 确认框
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
//    completionHandler(YES);
//}
//
//// 警告框
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    HDLog(@"%@", message);
//    completionHandler();
//}

@end
