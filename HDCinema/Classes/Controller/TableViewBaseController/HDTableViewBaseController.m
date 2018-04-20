//
//  HDTableViewBaseController.m
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewBaseController.h"
#import "HDTableViewGroupModel.h"
#import "HDTableViewBaseModel.h"
#import "HDTableViewBaseCell.h"

@interface HDTableViewBaseController ()

@end

@implementation HDTableViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}

- (void)showBaseTableView {
    [self createTableView];
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.baseTableView = tableView;
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - 懒加载
- (NSArray<HDTableViewGroupModel *> *)tableViewGroupModelArr {
    if (!_tableViewGroupModelArr) {
        _tableViewGroupModelArr = [NSArray array];
    }
    
    return _tableViewGroupModelArr;
}

- (HDTableViewGroupModel *)tableViewGroupModel {
    if (!_tableViewGroupModel) {
        _tableViewGroupModel = [[HDTableViewGroupModel alloc] init];
    }
    
    return _tableViewGroupModel;
}

- (HDTableViewBaseModel *)tableViewBaseModel {
    if (!_tableViewBaseModel) {
        _tableViewBaseModel = [[HDTableViewBaseModel alloc] init];
    }
    
    return _tableViewBaseModel;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableViewGroupModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableViewGroupModel = self.tableViewGroupModelArr[section];
    return self.tableViewGroupModel.tableViewBaseModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableViewGroupModel = self.tableViewGroupModelArr[indexPath.section];
    self.tableViewBaseModel = self.tableViewGroupModel.tableViewBaseModels[indexPath.row];
    
    // TODO: 如果有自定义模型对应的cell, 请此处处理.
    /* 如下代码(cell可参见HDTableViewBaseCell写法):
    if ([self.tableViewBaseModel isMemberOfClass:[HDCustomModel class]]) {
        HDCustomModel *customModel = (HDCustomModel *)self.tableViewBaseModel;
        HDTableViewCustomCell *customCell = [HDTableViewCustomCell tableViewCustomCellWithTableView:tableView];
        customCell.customModel = customModel;
        
        return customCell;
    }
    */
    
    HDTableViewBaseCell *baseCell = [HDTableViewBaseCell tableViewBaseCellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    baseCell.tableViewBaseModel = self.tableViewBaseModel;
    
    return baseCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.tableViewGroupModel = self.tableViewGroupModelArr[indexPath.section];
    self.tableViewBaseModel = self.tableViewGroupModel.tableViewBaseModels[indexPath.row];
    
    if (self.tableViewBaseModel.didSelectRowAtIndexPath) {
        self.tableViewBaseModel.didSelectRowAtIndexPath(indexPath);
        return; 
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    self.tableViewGroupModel = self.tableViewGroupModelArr[section];
    return self.tableViewGroupModel.headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    self.tableViewGroupModel = self.tableViewGroupModelArr[section];
    return self.tableViewGroupModel.footerText;
}

@end

