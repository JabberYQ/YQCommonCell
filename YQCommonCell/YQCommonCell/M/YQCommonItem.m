//
//  YQCommonCellItem.m
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQCommonItem.h"

@implementation YQCommonItem
YQPropSetFuncImplementation(YQCommonItem, BOOL, selectAbility);
YQPropSetFuncImplementation(YQCommonItem, BOOL, selectHighlight);
YQPropSetFuncImplementation(YQCommonItem, CGFloat, cellHeight);
YQPropSetFuncImplementation(YQCommonItem, Class, destVcClass);
YQPropSetFuncImplementation(YQCommonItem, UIColor *, cellBackgroudColor);
YQPropSetFuncImplementation(YQCommonItem, YQCommonCellSelectBlock, operation);

YQPropSetFuncImplementation(YQCommonItem, BOOL, arrow);

YQPropSetFuncImplementation(YQCommonItem, NSString *, icon);
YQPropSetFuncImplementation(YQCommonItem, CGFloat, iconWidth);

YQPropSetFuncImplementation(YQCommonItem, NSString *, title);
YQPropSetFuncImplementation(YQCommonItem, UIFont *, titleLableFont);
YQPropSetFuncImplementation(YQCommonItem, UIColor *, titleLableColor);
YQPropSetFuncImplementation(YQCommonItem, NSAttributedString *, attributedTitle);

YQPropSetFuncImplementation(YQCommonItem, NSString *, badgeValue);
YQPropSetFuncImplementation(YQCommonItem, YQBadgeViewLayout, badgeLayout);

YQPropSetFuncImplementation(YQCommonItem, NSString *, assistLabelText);
YQPropSetFuncImplementation(YQCommonItem, UIFont *, assistLabelFont);
YQPropSetFuncImplementation(YQCommonItem, UIColor *, assistLabelColor);
YQPropSetFuncImplementation(YQCommonItem, NSAttributedString *, assistLabelAttributedText);
YQPropSetFuncImplementation(YQCommonItem, CGFloat, assistLabelX);

YQPropSetFuncImplementation(YQCommonItem, NSString *, assistFieldText);
YQPropSetFuncImplementation(YQCommonItem, UIKeyboardType, assistFieldKeyboardType);
YQPropSetFuncImplementation(YQCommonItem, UIFont *, assistFieldFont);
YQPropSetFuncImplementation(YQCommonItem, UIColor *, assistFieldColor);
YQPropSetFuncImplementation(YQCommonItem, NSString *, assistFieldPlaceholderText);
YQPropSetFuncImplementation(YQCommonItem, UIColor *, assistFieldPlaceholderColor);
YQPropSetFuncImplementation(YQCommonItem, CGFloat, assistFieldX);
YQPropSetFuncImplementation(YQCommonItem, YQCommonFieldTextChangeBlock, fieldTextChangeBlock);
YQPropSetFuncImplementation(YQCommonItem, YQCommonFieldEditFinishBlock, fieldEditFinishBlock);

YQPropSetFuncImplementation(YQCommonItem, UIView *, assistCustomView);
YQPropSetFuncImplementation(YQCommonItem, YQAssistCustomViewLayout, assistCustomViewLayout);
YQPropSetFuncImplementation(YQCommonItem, BOOL, assistCustomViewClipsToBounds);

YQPropSetFuncImplementation(YQCommonItem, BOOL, hadBottomLine);
YQPropSetFuncImplementation(YQCommonItem, UIColor *, bottomLineColor);
YQPropSetFuncImplementation(YQCommonItem, CGFloat, bottomLineHeight);
YQPropSetFuncImplementation(YQCommonItem, CGFloat, bottomLineX);

- (instancetype)init
{
    if (self = [super init]) {
        /* 默认设置 */
        self.cellHeight = 44.f;
        self.cellBackgroudColor = [UIColor whiteColor];
        self.titleLableFont = [UIFont systemFontOfSize:16];
        self.titleLableColor = [UIColor blackColor];
        self.badgeLayout = YQBadgeViewLayoutLeft;
        self.assistLabelFont = [UIFont systemFontOfSize:15];
        self.assistLabelColor = [UIColor blackColor];
        self.assistLabelX = 0.f;
        self.assistFieldFont = [UIFont systemFontOfSize:15];
        self.assistFieldColor = [UIColor blackColor];
        self.assistFieldKeyboardType = UIKeyboardTypeDefault;
        self.assistFieldX = 0.f;
        self.selectAbility = YES;
        self.selectHighlight = YES;
        self.assistCustomViewLayout = YQAssistCustomViewLayoutRight;
        self.assistCustomViewClipsToBounds = YES;
        self.hadBottomLine = YES;
        self.bottomLineHeight = 1.0f;
        self.bottomLineX = -1.0f;
        self.bottomLineColor = [UIColor colorWithWhite:0.85 alpha:0.6];
    }
    return self;
}

@end
