//
//  HDTableViewGroupModel.m
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewGroupModel.h"
#import "HDTableViewBaseModel.h"

@implementation HDTableViewGroupModel

+ (__kindof HDTableViewGroupModel *)tableViewGroupModelWithHeaderText:(NSString *)headerText baseModels:(NSArray<__kindof HDTableViewBaseModel *> *)tableViewBaseModels footerText:(NSString *)footerText {
    HDTableViewGroupModel *tableViewGroupModel = [[self alloc] init];
    
    tableViewGroupModel.headerText = headerText;
    tableViewGroupModel.tableViewBaseModels = tableViewBaseModels;
    tableViewGroupModel.footerText = footerText;
    
    return tableViewGroupModel;
}

@end
