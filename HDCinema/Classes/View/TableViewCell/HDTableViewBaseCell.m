//
//  HDTableViewBaseCell.m
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewBaseCell.h"
#import "HDTableViewBaseModel.h"

@implementation HDTableViewBaseCell

+ (__kindof HDTableViewBaseCell *)tableViewBaseCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    static NSString * const tableViewBaseCellID = @"tableViewBaseCellID";
    HDTableViewBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewBaseCellID];
    
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:tableViewBaseCellID];
    }
    
    return cell;
}

- (void)setTableViewBaseModel:(HDTableViewBaseModel *)tableViewBaseModel {
    _tableViewBaseModel = tableViewBaseModel;
    [self updateBaseData];
}

/**
 *  设置基础数据
 */
- (void)updateBaseData {
    self.textLabel.text = self.tableViewBaseModel.labelText;
    self.detailTextLabel.text = self.tableViewBaseModel.detailedText;
    
    if (self.tableViewBaseModel.iconName.length > 0) {
        self.imageView.image = [UIImage imageNamed:self.tableViewBaseModel.iconName];
    }
}

@end
