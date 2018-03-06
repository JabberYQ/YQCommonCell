//
//  YQCommonGroup.m
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQCommonGroup.h"
#import "YQCommonItem.h"

@implementation YQCommonGroup
{
    UILabel *_headerLabel;
    UILabel *_footerLabel;
    BOOL _isLastItemHadBottomLine; // 暂存
}



YQPropSetFuncImplementation(YQCommonGroup, NSArray *, items);
YQPropSetFuncImplementation(YQCommonGroup, BOOL, hiddenLastRowBottomLine);

YQPropSetFuncImplementation(YQCommonGroup, CGFloat, headerHeight);
YQPropSetFuncImplementation(YQCommonGroup, NSString *, headerTitle);
YQPropSetFuncImplementation(YQCommonGroup, UIColor *, headerTitleColor);
YQPropSetFuncImplementation(YQCommonGroup, UIFont *, headerTitleFont);
YQPropSetFuncImplementation(YQCommonGroup, CGFloat, headerTitleHeight);
YQPropSetFuncImplementation(YQCommonGroup, YQHeaderTitleLayout, headerTitleLayout);
YQPropSetFuncImplementation(YQCommonGroup, UIView *, headerView);

YQPropSetFuncImplementation(YQCommonGroup, CGFloat, footerHeight);
YQPropSetFuncImplementation(YQCommonGroup, NSString *, footerTitle);
YQPropSetFuncImplementation(YQCommonGroup, UIColor *, footerTitleColor);
YQPropSetFuncImplementation(YQCommonGroup, UIFont *, footerTitleFont);
YQPropSetFuncImplementation(YQCommonGroup, CGFloat, footerTitleHeight);
YQPropSetFuncImplementation(YQCommonGroup, YQFooterTitleLayout, footerTitleLayout);
YQPropSetFuncImplementation(YQCommonGroup, UIView *, footerView);

+ (instancetype)groupWithItems:(NSArray *)items
{
    YQCommonGroup *group = [[YQCommonGroup alloc] init];
    group.items = items;
    return group;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.headerHeight = 20.f;
        self.footerHeight = 0.01f;
        self.headerTitleFont = [UIFont systemFontOfSize:16];
        self.headerTitleColor = [UIColor grayColor];
        self.headerTitleHeight = 50.f;
        self.headerTitleLayout = YQHeaderTitleLayoutLeft;
        self.footerTitleFont = [UIFont systemFontOfSize:16];
        self.footerTitleColor = [UIColor grayColor];
        self.footerTitleHeight = 50.f;
        self.footerTitleLayout = YQFooterTitleLayoutLeft;
        self.hiddenLastRowBottomLine = YES;
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    if (self.hiddenLastRowBottomLine) {
        YQCommonItem *lastItem = [items lastObject];
        _isLastItemHadBottomLine = lastItem.hadBottomLine;
        lastItem.hadBottomLine = NO;
    }
    
}

- (void)setHiddenLastRowBottomLine:(BOOL)hiddenLastRowBottomLine
{
    _hiddenLastRowBottomLine = hiddenLastRowBottomLine;
    if (hiddenLastRowBottomLine == NO && self.items) { // 不需要隐藏最后一行的分割线
        YQCommonItem *lastItem = [self.items lastObject];
        lastItem.hadBottomLine = _isLastItemHadBottomLine;
    }
}

/** Header */
- (void)setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle = headerTitle;
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.text = self.headerTitle;
    _headerLabel.font = self.headerTitleFont;
    _headerLabel.textColor = self.headerTitleColor;
    _headerLabel.textAlignment = (NSTextAlignment)self.headerTitleLayout;
    _headerLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.headerTitleHeight);
    self.headerView = _headerLabel;
}

- (void)setHeaderTitleFont:(UIFont *)headerTitleFont
{
    _headerTitleFont = headerTitleFont;
    if (_headerLabel) {
        _headerLabel.font = headerTitleFont;
    }
}

- (void)setHeaderTitleColor:(UIColor *)headerTitleColor
{
    _headerTitleColor = headerTitleColor;
    if (_headerLabel) {
        _headerLabel.textColor = headerTitleColor;
    }
}

- (void)setHeaderTitleHeight:(CGFloat)headerTitleHeight
{
    _headerTitleHeight = headerTitleHeight;
    if (_headerLabel) {
        _headerLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerTitleHeight);
    }
}

- (void)setHeaderTitleLayout:(YQHeaderTitleLayout)headerTitleLayout
{
    _headerTitleLayout = headerTitleLayout;
    if (_headerLabel) {
        _headerLabel.textAlignment = (NSTextAlignment)headerTitleLayout;
    }
}

/** Footer */
- (void)setFooterTitle:(NSString *)footerTitle
{
    _footerTitle = footerTitle;
    _footerLabel = [[UILabel alloc] init];
    _footerLabel.text = self.footerTitle;
    _footerLabel.font = self.footerTitleFont;
    _footerLabel.textColor = self.footerTitleColor;
    _footerLabel.textAlignment = (NSTextAlignment)self.footerTitleLayout;
    _footerLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.headerTitleHeight);
    self.footerView = _footerLabel;
}

- (void)setFooterTitleFont:(UIFont *)footerTitleFont
{
    _footerTitleFont = footerTitleFont;
    if (_footerLabel) {
        _footerLabel.font = footerTitleFont;
    }
}

- (void)setFooterTitleColor:(UIColor *)footerTitleColor
{
    _footerTitleColor = footerTitleColor;
    if (_footerLabel) {
        _footerLabel.textColor = footerTitleColor;
    }
}

- (void)setFooterTitleHeight:(CGFloat)footerTitleHeight
{
    _footerTitleHeight = footerTitleHeight;
    if (_footerLabel) {
        _footerLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footerTitleHeight);
    }
}

- (void)setFooterTitleLayout:(YQFooterTitleLayout)footerTitleLayout
{
    _footerTitleLayout = footerTitleLayout;
    if (_footerLabel) {
        _footerLabel.textAlignment = (NSTextAlignment)footerTitleLayout;
    }
}
@end
