//
//  HDTraceViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDTraceViewController.h"
#import "HDTableViewGroupModel.h"
#import "HDTableViewBaseModel.h"
#import "HDSupportViewController.h"

static NSDictionary *_analyticalLinesDic = nil;

@interface HDTraceViewController ()

/** 解析地址 */
@property (nonatomic, strong) NSArray *traceURLStringArr;

@end

@implementation HDTraceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"线路解析";
    [self loadLocalData];
    [self showBaseTableView];
    [self addTableViewModel];
}

- (void)addTableViewModel {
    weakSelf(weakSelf);
    
    HDTableViewBaseModel *weChat = [HDTableViewBaseModel tableViewBaseModelWithIconName:nil labelText:@"微信赞助" detailedText:@"你的支持是我的更新的动力" didSelectRowAtIndexPath:^(NSIndexPath *indexPath) {
        HDSupportViewController *support = [[HDSupportViewController alloc] initWithSupportType:HDSupportType_WeChat];
        [weakSelf.navigationController pushViewController:support animated:YES];
    }];
    
    HDTableViewBaseModel *alipay = [HDTableViewBaseModel tableViewBaseModelWithIconName:nil labelText:@"支付宝赞助" detailedText:@"你的支持是我的更新的动力" didSelectRowAtIndexPath:^(NSIndexPath *indexPath) {
        HDSupportViewController *support = [[HDSupportViewController alloc] initWithSupportType:HDSupportType_Alipay];
        [weakSelf.navigationController pushViewController:support animated:YES];
    }];
    
    HDTableViewGroupModel *oneGroupModel = [HDTableViewGroupModel tableViewGroupModelWithHeaderText:@"你的支持是我的更新的动力" baseModels:@[weChat, alipay] footerText:nil];
    NSArray *arr = _analyticalLinesDic[@"list"];
    NSMutableArray *tempArr = [NSMutableArray array];
    
    NSMutableArray *tempTraceURLStringArr = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        [tempTraceURLStringArr addObject:dic[@"url"]];
        HDTableViewBaseModel *baseModel = [HDTableViewBaseModel tableViewBaseModelWithIconName:nil labelText:[NSString stringWithFormat:@"%@，此线路不行就换别的线路试试", dic[@"name"]] detailedText:@"点击就已复制链接可以电脑打开观看哦！！！" didSelectRowAtIndexPath:^(NSIndexPath *indexPath) {
            NSString *URLString = weakSelf.traceURLStringArr[indexPath.row];
            HDLog(@"URLString = %@", URLString);
            if ([weakSelf.delegate respondsToSelector:@selector(traceClick:)]) {
                [weakSelf.delegate traceClick:URLString];
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
       [tempArr addObject:baseModel];
    }
    
    self.traceURLStringArr = [NSArray arrayWithArray:tempTraceURLStringArr];
    HDTableViewGroupModel *twoGroupModel = [HDTableViewGroupModel tableViewGroupModelWithHeaderText:@"vip解析线路" baseModels:tempArr footerText:nil];
    
    self.tableViewGroupModelArr = @[oneGroupModel, twoGroupModel];
}

- (void)loadLocalData {
    if (_analyticalLinesDic) {
        return;
    }
    // https://iodefog.github.io/text/viplist.json 可自行写代码网上拉取，不用本地文件。（在此就懒得写代码了，因为这些链接也不会经常变。就使用本地文件，也懒得使用字典转模型了。）
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AnalyticalLines" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    _analyticalLinesDic = dict;
}

@end
