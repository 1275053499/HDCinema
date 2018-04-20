//
//  UIBarButtonItem+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HDExtension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param imageName     图片
 *  @param highImageName 高亮的图片
 *
 *  @return 创建完的item
 */
+ (instancetype)hd_itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName highImageName:(NSString *)highImageName;

@end
