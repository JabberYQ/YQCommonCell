//
//  YQCommonCellItem.m
//  ZZDCDemo
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQCommonItem.h"

@implementation YQCommonItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    return [self itemWithTitle:title icon:icon arrow:NO];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow
{
    return [self itemWithTitle:title icon:icon arrow:arrow screenSeparator:NO];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow screenSeparator:(BOOL)screenSeparator
{
    YQCommonItem *item = [[YQCommonItem alloc] init];
    /* 初始化数据 */
    item.title = title;
    item.icon = icon;
    item.arrow = arrow;
    item.screenSeparator = screenSeparator;
    
    /* 默认数据 */
    item.titleLableFont = [UIFont boldSystemFontOfSize:16];
    item.titleLableColor = [UIColor blackColor];
    item.assistLabelFont = [UIFont systemFontOfSize:15];
    item.assistLabelColor = [UIColor grayColor];
    item.assistImageWidth = 30.f;
    
    return item;
}


@end
