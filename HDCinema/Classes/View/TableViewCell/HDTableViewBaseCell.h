//
//  HDTableViewBaseCell.h
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDTableViewBaseModel;

@interface HDTableViewBaseCell : UITableViewCell

/** TableView基础模型 */
@property (nonatomic, strong) HDTableViewBaseModel *tableViewBaseModel;


/**
 *  快速创建重用HDTableViewBaseCell对象
 */
+ (__kindof HDTableViewBaseCell *)tableViewBaseCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
