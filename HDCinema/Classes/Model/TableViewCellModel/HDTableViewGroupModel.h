//
//  HDTableViewGroupModel.h
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDTableViewBaseModel;

@interface HDTableViewGroupModel : NSObject

/** 组头文本 */
@property (nonatomic, copy) NSString *headerText;

/** 存放每组里面的基本模型或者基本模型子类 */
@property (nonatomic, strong) NSArray<__kindof HDTableViewBaseModel *> *tableViewBaseModels;

/** 组尾文本 */
@property (nonatomic, copy) NSString *footerText;


/**
 *  快速创建HDTableViewGroupModel对象
 *
 *  @param headerText 组头文本
 *  @param tableViewBaseModels 存放每组里面的基本模型
 *  @param footerText 组尾文本
 */
+ (__kindof HDTableViewGroupModel *)tableViewGroupModelWithHeaderText:(NSString *)headerText baseModels:(NSArray<__kindof HDTableViewBaseModel *> *)tableViewBaseModels footerText:(NSString *)footerText;

@end
