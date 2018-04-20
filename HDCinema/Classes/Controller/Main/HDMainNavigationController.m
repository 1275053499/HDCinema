//
//  HDMainNavigationController.m
//  Test
//
//  Created by HeDong on 16/7/25.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDMainNavigationController.h"
#import "UIBarButtonItem+HDExtension.h"

@interface HDMainNavigationController ()

@end

@implementation HDMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;

        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem hd_itemWithTarget:self action:@selector(back) imageName:@"nav_btn_back_gray_normal" highImageName:@"nav_btn_back_gray_h"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
