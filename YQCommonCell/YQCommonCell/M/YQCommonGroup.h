//
//  YQCommonGroup.h
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YQHeaderTitleLayout)
{
    YQHeaderTitleLayoutLeft = 0,
    YQHeaderTitleLayoutCenter = 1,
    YQHeaderTitleLayoutRight = 2,
};

typedef NS_ENUM(NSInteger, YQFooterTitleLayout)
{
    YQFooterTitleLayoutLeft = 0,
    YQFooterTitleLayoutCenter = 1,
    YQFooterTitleLayoutRight = 2,
};


@interface YQCommonGroup : NSObject
/** 每个Section内部内容 */
@property (nonatomic, strong) NSArray *items;

/** Section Header高 默认40 如果设置了Header标题或者HeaderView自定义，该属性无效，以试图的高为准*/
@property (nonatomic, assign) CGFloat headerHeight;
/** Section Header标题 */
@property (nonatomic, copy) NSString *headerTitle;
/** Section Header标题颜色 默认灰色*/
@property (nonatomic, strong) UIColor *headerTitleColor;
/** Section Header标题大小 默认16*/
@property (nonatomic, strong) UIFont *headerTitleFont;
/** Section Header标题高度 默认50*/
@property (nonatomic, assign) CGFloat headerTitleHeight;
/** Section Header标题位置 默认居左*/
@property (nonatomic, assign) YQHeaderTitleLayout headerTitleLayout;
/** Section HeaderView自定义 */
@property (nonatomic, strong) UIView *headerView;

/** Section Footer高 默认0.01 如果设置了Footer标题或者FooterView自定义，该属性无效，以试图的高为准*/
@property (nonatomic, assign) CGFloat footerHeight;
/** Section Footer标题 */
@property (nonatomic, copy) NSString *footerTitle;
/** Section Footer标题颜色 默认灰色*/
@property (nonatomic, strong) UIColor *footerTitleColor;
/** Section Footer标题大小 默认16*/
@property (nonatomic, strong) UIFont *footerTitleFont;
/** Section Footer标题高度 默认50*/
@property (nonatomic, assign) CGFloat footerTitleHeight;
/** Section Footer标题位置 默认居左*/
@property (nonatomic, assign) YQFooterTitleLayout footerTitleLayout;
/** Section FooterView */
@property (nonatomic, strong) UIView *footerView;

+ (instancetype)groupWithItems:(NSArray *)items;
@end
