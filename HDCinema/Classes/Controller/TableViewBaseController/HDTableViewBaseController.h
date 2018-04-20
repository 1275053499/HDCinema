//
//  HDTableViewBaseController.h
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDBaseViewController.h"

@class HDTableViewGroupModel, HDTableViewBaseModel;

@interface HDTableViewBaseController : HDBaseViewController
<
UITableViewDelegate,
UITableViewDataSource
>

/** 基础TableView */
@property (nonatomic, weak) UITableView *baseTableView;

/** 存放Group组模型 */
@property (nonatomic, strong) NSArray<__kindof HDTableViewGroupModel *> *tableViewGroupModelArr;

/** TableView组模型 */
@property (nonatomic, strong) HDTableViewGroupModel *tableViewGroupModel;

/** TableView基本模型 */
@property (nonatomic, strong) HDTableViewBaseModel *tableViewBaseModel;


/**
 *  显示TableView视图(默认不显示, 需要子类调用才可显示)
 *  可重写此方法, 设置自定义baseTableView.
 *  默认baseTableView是UITableViewStyleGrouped模式
 */
- (void)showBaseTableView;

- (UITableViewStyle)tableViewStyle;

@end
