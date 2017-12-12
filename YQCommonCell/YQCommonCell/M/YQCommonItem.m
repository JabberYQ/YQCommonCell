//
//  YQCommonCellItem.m
//  YQCommonCell
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
    return item;
}

- (instancetype)init
{
    if (self = [super init]) {
        /* 默认设置 */
        self.cellHeight = 44.f;
        self.cellBackgroudColor = [UIColor whiteColor];
        self.titleLableFont = [UIFont boldSystemFontOfSize:16];
        self.titleLableColor = [UIColor blackColor];
        self.assistLabelFont = [UIFont systemFontOfSize:15];
        self.assistImageWidth = 30.f;
        self.selectAbility = YES;
        self.selectHighlight = YES;
        self.assistCustomViewLayout = YQAssistCustomViewLayoutRight;
    }
    return self;
}

@end
