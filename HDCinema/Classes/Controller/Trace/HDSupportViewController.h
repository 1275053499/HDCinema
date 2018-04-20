//
//  HDSupportViewController.h
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDBaseViewController.h"

typedef NS_ENUM(NSInteger, HDSupportType) {
    HDSupportType_WeChat = 1,
    HDSupportType_Alipay = 2
};

@interface HDSupportViewController : HDBaseViewController

- (instancetype)initWithSupportType:(HDSupportType)supportType;

@end
