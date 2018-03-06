//
//  YQCommonGroup.h
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YQCommonMacro.h"

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
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, NSArray *,           items)
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, BOOL,                hiddenLastRowBottomLine) ///< hidden last row bottomLine default YES.

YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             headerHeight) ///< default 20.
YQPropStatementAndFuncStatement(copy,    YQCommonGroup, NSString *,          headerTitle) ///< default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIColor *,           headerTitleColor) ///< default [UIColor grayColor].
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIFont *,           headerTitleFont) ///< default [UIFont systemFontOfSize:16].
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             headerTitleHeight) ///< default 50.
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, YQHeaderTitleLayout, headerTitleLayout) ///< default YQHeaderTitleLayoutLeft.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIView *,            headerView) ///< default nil.


YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             footerHeight) ///< default 0.01.
YQPropStatementAndFuncStatement(copy,    YQCommonGroup, NSString *,          footerTitle) ///< default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIColor *,           footerTitleColor) ///< default [UIColor grayColor].
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIFont *,           footerTitleFont) ///< default [UIFont systemFontOfSize:16].
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             footerTitleHeight) ///< default 50.
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, YQFooterTitleLayout, footerTitleLayout) ///< default YQFooterTitleLayoutLeft.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIView *,            footerView) ///< default nil.

+ (instancetype)groupWithItems:(NSArray *)items;
@end
