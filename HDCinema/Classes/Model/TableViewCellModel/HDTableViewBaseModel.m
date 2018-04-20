//
//  HDTableViewBaseModel.m
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewBaseModel.h"

@implementation HDTableViewBaseModel

+ (__kindof HDTableViewBaseModel *)tableViewBaseModelWithIconName:(NSString *)iconName labelText:(NSString *)labelText detailedText:(NSString *)detailedText didSelectRowAtIndexPath:(Option)didSelectRowAtIndexPath {
    HDTableViewBaseModel *tableViewBaseModel = [[self alloc] init];
    
    tableViewBaseModel.iconName = iconName;
    tableViewBaseModel.labelText = labelText;
    tableViewBaseModel.detailedText = detailedText;
    tableViewBaseModel.didSelectRowAtIndexPath = didSelectRowAtIndexPath;
    
    return tableViewBaseModel;
}

@end
