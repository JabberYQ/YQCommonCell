//
//  YQCommonCellItem.h
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//  最普通的item

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YQCommonMacro.h"

typedef NS_ENUM(NSInteger, YQAssistCustomViewLayout)
{
    YQAssistCustomViewLayoutRight = 0,
    YQAssistCustomViewLayoutRightBottom = 1,
    YQAssistCustomViewLayoutBottom = 2,
    YQAssistCustomViewLayoutLeftBottom = 3,
    YQAssistCustomViewLayoutLeft = 4,
    YQAssistCustomViewLayoutLeftTop = 5,
    YQAssistCustomViewLayoutTop = 6,
    YQAssistCustomViewLayoutRightTop = 7,
    YQAssistCustomViewLayoutCenter = 8,
};

typedef NS_ENUM(NSInteger, YQBadgeViewLayout)
{
    YQBadgeViewLayoutLeft = 0,
    YQBadgeViewLayoutRight = 1,
};

typedef void (^YQCommonCellSelectBlock) (void);
typedef void (^YQCommonFieldTextChangeBlock) (NSString *text);
typedef BOOL (^YQCommonFieldEditFinishBlock) (NSString *text);


@interface YQCommonItem : NSObject

// cell 对应属性
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         selectAbility) ///< cell能否被点击 default YES.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         selectHighlight) ///< cell被点击是否高亮 default YES.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         arrow) ///< 是否有箭头 default NO.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      cellHeight) ///< cell的高度 default 44.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, Class,                        destVcClass) ///< 点击后的跳转控制器 default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    cellBackgroudColor) ///< cell背景颜色 default [UIColor whiteColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, YQCommonCellSelectBlock,      operation) ///< 点击后的跳转控制器 default nil.

// icon 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   icon) ///< 图标 default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      iconWidth) ///< 图标大小 default.

// title 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   title) ///< 标题 default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIFont *,                     titleLableFont) ///< 标题font default [UIFont systemFontOfSize:16].
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    titleLableColor) ///< 标题color default [UIFont BlackColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSAttributedString *,         attributedTitle) ///< 标题 default nil.

// badge 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   badgeValue) ///< 红点提醒 default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, YQBadgeViewLayout,            badgeLayout) ///< 红点提醒布局 default YQBadgeViewLayoutLeft.


// 辅助视图assistLabel 对应属性   NSAttributedString > NSString
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   assistLabelText) ///< 标题 default nil. lable.textAlignment = NSTextAlignmentRight;
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIFont *,                     assistLabelFont) ///< 标题font default [UIFont systemFontOfSize:15].
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    assistLabelColor) ///< 标题color default [UIFont BlackColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSAttributedString *,         assistLabelAttributedText) ///< 标题 default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      assistLabelX) ///< assistLabel X default 0. if>0 lable.textAlignment = NSTextAlignmentLeft;

// 辅助视图textField 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   assistFieldText) ///< textField.text default nil. Field.textAlignment = NSTextAlignmentRight;
YQPropStatementAndFuncStatement(assign,  YQCommonItem, UIKeyboardType,               assistFieldKeyboardType) ///< textField.keyboardType
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIFont *,                     assistFieldFont) ///< textField.font [UIFont systemFontOfSize:15].
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    assistFieldColor) ///< textField.textColor default [UIFont BlackColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   assistFieldPlaceholderText) ///< textField.placeholder default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    assistFieldPlaceholderColor) ///< textField.placeholderTextColor
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      assistFieldX) ///< assistField X default 0. if>0 Field.textAlignment = NSTextAlignmentLeft;
YQPropStatementAndFuncStatement(copy,    YQCommonItem, YQCommonFieldTextChangeBlock, fieldTextChangeBlock)
YQPropStatementAndFuncStatement(copy,    YQCommonItem, YQCommonFieldEditFinishBlock, fieldEditFinishBlock)

// 辅助视图自定义customview 对应属性
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIView *,                     assistCustomView) ///< CustomView default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, YQAssistCustomViewLayout,     assistCustomViewLayout) ///< CustomView Layout default YQAssistCustomViewLayoutRight
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         assistCustomViewClipsToBounds) ///< CustomView ClipsToBounds default YES.

// 分割线 对应属性
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         hadBottomLine) ///< BottomLine default YES.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    bottomLineColor) ///< BottomLineColor default [UIColor colorWithWhite:0.85 alpha:0.6]
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      bottomLineHeight) ///< BottomLine default 1.0f.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      bottomLineX) ///< BottomLine default line.x = titlelabel.x
@end
