//
//  HDMainTabBarController.m
//  Test
//
//  Created by HeDong on 16/7/25.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDMainTabBarController.h"
#import "HDMainNavigationController.h"
#import "HDTencentTVViewController.h"
#import "HDIQiYiTVViewController.h"
#import "HDYouKuTVViewController.h"
#import "HDMangoTVViewController.h"
#import "HDOptionalViewController.h"


@interface HDMainTabBarController ()

@end

@implementation HDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self createChildViewController];
}

- (void)createChildViewController {
    HDTencentTVViewController *tencentTV = [[HDTencentTVViewController alloc] init];
    [self addChildVc:tencentTV title:@"腾讯视频" imageName:@"tencent_tv" selectedImageName:@"default_seven"];
    
    HDIQiYiTVViewController *aiQiYiTV = [[HDIQiYiTVViewController alloc] init];
    [self addChildVc:aiQiYiTV title:@"爱奇艺" imageName:@"aiqiyi_tv" selectedImageName:@"default_seven"];
    
    HDYouKuTVViewController *youKuTV = [[HDYouKuTVViewController alloc] init];
    [self addChildVc:youKuTV title:@"优酷" imageName:@"youku_tv" selectedImageName:@"default_seven"];
    
    HDMangoTVViewController *mangoTV = [[HDMangoTVViewController alloc] init];
    [self addChildVc:mangoTV title:@"芒果TV" imageName:@"mango_tv" selectedImageName:@"default_seven"];
    
    HDOptionalViewController *soHuTV = [[HDOptionalViewController alloc] init];
    [self addChildVc:soHuTV title:@"自选内容" imageName:@"so_hu_tv" selectedImageName:@"default_seven"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HDColorFromHex(0x999999);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = HDColorFromHex(0x333333);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 包装导航控制器
    HDMainNavigationController *nav = [[HDMainNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
