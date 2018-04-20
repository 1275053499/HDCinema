//
//  UIBarButtonItem+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import "UIBarButtonItem+HDExtension.h"
#import "UIView+HDExtension.h"

@implementation UIBarButtonItem (HDExtension)

+ (instancetype)hd_itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName highImageName:(NSString *)highImageName {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.hd_size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
