//
//  YQCommonCellItem.h
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//  最普通的item

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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


@interface YQCommonItem : NSObject

/************************************ cell 数据源 *************************************/

/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 是否有箭头 默认为NO */
@property (nonatomic, assign, getter=isArrow) BOOL arrow;
/** 是否有分割线 默认为YES */
@property (nonatomic, assign, getter=isHadBottomLine) BOOL hadBottomLine;
/** 辅助图片本地Str */
@property (nonatomic, copy) NSString *assistImageFileStr;
/** 辅助图片网络Str */
@property (nonatomic, copy) NSString *assistImageURLStr;
/** 辅助信息 */
@property (nonatomic, copy) NSString *assistLabelText;
/* assistFieldText 与 assistFieldPlaceholderText 的区别在于前者为field.text属性 后者为field.placeholder属性 */
/** 辅助textField */
@property (nonatomic, copy) NSString *assistFieldText;
/** 辅助textField 的 placeholder */
@property (nonatomic, copy) NSString *assistFieldPlaceholderText;
/** 辅助自定义视图 */
@property (nonatomic, strong) UIView *assistCustomView;
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;


/************************************ cell 点击响应设置 *************************************/

/** cell能否被点击 默认YES */
@property (nonatomic, assign, getter=isSelectAbility) BOOL selectAbility;
/** cell被点击是否高亮 默认YES */
@property (nonatomic, assign, getter=isSelectHighlight) BOOL selectHighlight;
/** block 只能用 copy */
@property (nonatomic, copy) void (^operation)(void);
/** 点击这行cell需要跳转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;

/************************************ cell 内部控件配置 *************************************/

/** cell行高 默认44 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 图标大小 默认系统大小 */
@property (nonatomic, assign) CGFloat iconWidth;
/** 辅助图像大小 默认30 */
@property (nonatomic, assign) CGFloat assistImageWidth;
/** 辅助图像圆角化 默认不处理 */
@property (nonatomic, assign) CGFloat assistImageCornerRadius;
/** cell背景颜色 默认白色 */
@property (nonatomic, strong) UIColor *cellBackgroudColor;
/** 标题字体大小 默认16 */
@property (nonatomic, strong) UIFont *titleLableFont;
/** 标题颜色 默认黑色 */
@property (nonatomic, strong) UIColor *titleLableColor;
/** 辅助字体大小 默认15 */
@property (nonatomic, strong) UIFont *assistLabelFont;
/** 辅助颜色 默认grayColor */
@property (nonatomic, strong) UIColor *assistLabelColor;
/** 辅助自定义视图的位置 默认靠右  */
@property (nonatomic, assign) YQAssistCustomViewLayout assistCustomViewLayout;
/** 分割线颜色 默认[UIColor colorWithWhite:0.85 alpha:0.6] */
@property (nonatomic, strong) UIColor *bottomLineColor;
/** 分割线高度  默认1*/
@property (nonatomic, assign) CGFloat bottomLineHeight;
/** 分割线X 默认和cell的textlabel平齐*/
@property (nonatomic, assign) CGFloat bottomLineX;

/**
 初始化一个item

 @param title 标题
 @param icon 图标
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;


/**
 初始化一个item

 @param title 标题
 @param icon 图标
 @param arrow 是否存在跳转箭头
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow;


/**
 初始化一个item
 
 @param title 标题
 @param icon 图标
 @param arrow 是否存在跳转箭头
 @param hadBottomLine 是否有分割线
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow hadBottomLine:(BOOL)hadBottomLine;
@end
