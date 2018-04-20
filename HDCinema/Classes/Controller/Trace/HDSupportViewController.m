//
//  HDSupportViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDSupportViewController.h"

@interface HDSupportViewController ()

/** 赞助类型 */
@property (nonatomic, assign) HDSupportType supportType;

@end

@implementation HDSupportViewController

- (instancetype)initWithSupportType:(HDSupportType)supportType {
    if (self = [super init]) {
        self.supportType = supportType;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
}

- (void)createSubviews {
    UIImage *image = nil;
    if (self.supportType == HDSupportType_WeChat) {
        image = [UIImage imageNamed:@"wechatISupport"];
    } else {
        image = [UIImage imageNamed:@"alipaySupport"];
    }
    
    UIImageView *supportImageView = [[UIImageView alloc] init];
    supportImageView.image = image;
    supportImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:supportImageView];
    
    [supportImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

@end
