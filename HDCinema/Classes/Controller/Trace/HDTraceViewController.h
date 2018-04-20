//
//  HDTraceViewController.h
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDTableViewBaseController.h"

@protocol HDTraceViewControllerDelegate <NSObject>

@optional
- (void)traceClick:(NSString *)URLString;

@end

@interface HDTraceViewController : HDTableViewBaseController

/** 代理 */
@property (nonatomic, weak) id<HDTraceViewControllerDelegate> delegate;

@end
